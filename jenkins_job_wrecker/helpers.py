# encoding=utf8
import xml.etree.ElementTree as ET
import functools
import re

et_to_string = functools.partial(ET.tostring, encoding="unicode", method="xml")

_trues = {"true", "True", "Yes", "yes", "1"}


def camel_case_to_dashes(s):
    return "-".join(part.lower() for part in re.split(r"([A-Z][a-z]*)", s) if part)


def get_bool(txt):
    return txt in _trues


def gen_raw(xml, parent):
    xml_string = et_to_string(xml)
    assert isinstance(xml_string, str)
    node = {"raw": {"xml": xml_string}}
    parent.append(node)
