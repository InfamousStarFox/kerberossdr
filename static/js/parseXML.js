function parseXml(xmlStr) {
  if (typeof window.DOMParser != "undefined") {
    return new window.DOMParser().parseFromString(xmlStr, "text/xml");
  }
  // If Internet Explorer
  else if (typeof window.ActiveXObject != "undefined" && window.ActiveXObject("Microsoft.XMLDOM")) {
    var xmlDoc = new window.ActiveXObject("Microsoft.XMLDOM");
    xmlDoc.async = "false";
    xmlDoc.loadXML(xmlStr);
    return xmlDoc;
  }
  else {
    alert("Compass XML Parsing not supported");
    return;
  }
}
