# encoding=utf8
import xml.etree.ElementTree as ET

_trues = {"true", "True", "Yes", "yes", "1"}


def get_bool(txt):
    return txt in _trues


def gen_raw(xml, parent):
    xml_string = ET.tostring(xml, encoding="unicode", method="xml")
    assert isinstance(xml_string, str)
    node = {"raw": {"xml": xml_string}}
    parent.append(node)
