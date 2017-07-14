import os
import logging
import yaml
import threading
from PySide import QtCore, QtGui
#from PyQt4 import QtCore, QtGui
from ui.mainwindow import Ui_MainWindow
import subprocess

logger = logging.getLogger(__name__)

class MainWindow(QtGui.QMainWindow):
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        self.list_components()
        
    def list_components(self):
        componets = subprocess.check_output(
            'hr cmd list_components install'.split(' '))
        componets = componets.splitlines()

        for component in ['head', 'head-deps', 'opencog', 'opencog-deps']:
            if component in componets:
                componets.remove(component)

        installed_componets = subprocess.check_output(
            'hr cmd list_installed'.split(' '))
        installed_componets = installed_componets.splitlines()

        self.ui.componentTableWidget.setColumnCount(1)
        self.ui.componentTableWidget.setRowCount(len(componets))
        for col, key in enumerate(componets):
            item = QtGui.QTableWidgetItem(key)
            if key in installed_componets:
                item.setCheckState(QtCore.Qt.Checked)
            else:
                item.setCheckState(QtCore.Qt.Unchecked)
            self.ui.componentTableWidget.setItem(0, col, item)

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
