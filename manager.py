import os
import logging
import yaml
import threading
from PySide import QtCore, QtGui
#from PyQt4 import QtCore, QtGui
from ui.mainwindow import Ui_MainWindow
import subprocess
from debian import deb822
import gzip

logger = logging.getLogger(__name__)
CWD = os.path.abspath(os.path.dirname(__file__))

class MainWindow(QtGui.QMainWindow):
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        self.debs = {}
        self.parse_packages()
        self.list_components()
        self.list_installed_components()
        self.update_table()

    def list_components(self):
        components = subprocess.check_output(
            'hr cmd list_components install'.split(' '))
        components = components.splitlines()
        for component in ['head', 'head-deps', 'opencog', 'opencog-deps']:
            if component in components:
                components.remove(component)
        self.components = components

    def list_installed_components(self):
        installed_components = subprocess.check_output(
            'hr cmd list_installed'.split(' '))
        self.installed_components = installed_components.splitlines()


    def parse_packages(self):
        self.debs = {}
        package_file = os.path.join(CWD, 'Packages.gz')
        with gzip.open(package_file, 'rb') as f:
            content = f.read()
            packages = content.strip().split('\n\n')
            for package in packages:
                deb = deb822.Deb822(package)
                name = deb['Package']
                self.debs[name] = deb

    def get_installed_versions(self, components):
        cmd = r"""dpkg-query -W -f='${Package} ${Status} ${Version}\n' """+' '.join(components)
        versions = subprocess.check_output(cmd, shell=True).splitlines()
        installed_versions = {}
        for v in versions:
            if 'installed' in v:
                toks = v.split()
                if len(toks) > 4:
                    installed_versions[toks[0]] = toks[-1]
        return installed_versions

    def update_table(self):
        installed_versions = self.get_installed_versions(self.installed_components)

        self.ui.componentTableWidget.setColumnCount(5)
        self.ui.componentTableWidget.setRowCount(len(self.components))
        self.ui.componentTableWidget.setColumnWidth(0, 30)
        self.ui.componentTableWidget.setColumnWidth(1, 300)
        self.ui.componentTableWidget.setColumnWidth(2, 120)
        self.ui.componentTableWidget.setColumnWidth(3, 120)
        self.ui.componentTableWidget.setHorizontalHeaderLabels(
            ['S', 'Package', 'Installed Version', 'Latest Version', 'Description'])

        for row, key in enumerate(self.components):
            status = QtGui.QTableWidgetItem()
            if key in self.installed_components:
                status.setCheckState(QtCore.Qt.Checked)
            else:
                status.setCheckState(QtCore.Qt.Unchecked)
            self.ui.componentTableWidget.setItem(row, 0, status)
            item = QtGui.QTableWidgetItem(key)
            self.ui.componentTableWidget.setItem(row, 1, item)
            if key in self.debs:
                if key in installed_versions:
                    installed_version = QtGui.QTableWidgetItem(installed_versions[key])
                    self.ui.componentTableWidget.setItem(row, 2, installed_version)
                version = QtGui.QTableWidgetItem(self.debs[key]['Version'])
                self.ui.componentTableWidget.setItem(row, 3, version)
                desc = QtGui.QTableWidgetItem(self.debs[key]['Description'])
                self.ui.componentTableWidget.setItem(row, 4, desc)

if __name__ == "__main__":
    import sys
    fh = logging.FileHandler('manager.log', mode='w')
    fh.setLevel(logging.INFO)
    sh = logging.StreamHandler()
    sh.setLevel(logging.WARN)
    formatter = logging.Formatter(
        '[%(name)s][%(levelname)s] %(asctime)s: %(message)s')
    fh.setFormatter(formatter)
    sh.setFormatter(formatter)
    root_logger = logging.getLogger()
    root_logger.setLevel(logging.INFO)
    root_logger.addHandler(fh)
    root_logger.addHandler(sh)

    logger.info("Start")
    app = QtGui.QApplication(sys.argv)
    mainWindow = MainWindow()
    mainWindow.show()
    sys.exit(app.exec_())
