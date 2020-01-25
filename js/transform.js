function transformxml() {
    // XML:
    const xmltxt = document.getElementById('xmlcode').value;
    if (xmltxt == '') {
        alert('The XML is empty');
        return false;
    }
    const doc = new DOMParser();
    const xml = doc.parseFromString(xmltxt, 'text/xml');
    if (xml.documentElement.nodeName == 'parsererror') {
        document.write('Error in XML<br><br>' + xml.documentElement.childNodes[0].nodeValue);
        alert('Error in XML\n\n' + xml.documentElement.childNodes[0].nodeValue);
        return false;
    }
    // XSL:
    var xsltPrs = new XSLTProcessor();
    const xsltxt = document.getElementById('xsltcode').value;
    if (xsltxt == '') {
        alert('The XSLT is empty');
        return false;
    }
    const xsl = doc.parseFromString(xsltxt, 'text/xml');
    if (xsl.documentElement.nodeName == 'parsererror') {
        document.write('Error in XSLT<br><br>' + xsl.documentElement.childNodes[0].nodeValue);
        alert('Error in XSLT\n\n' + xsl.documentElement.childNodes[0].nodeValue);
        return false;
    }

    xsltPrs.importStylesheet(xsl);

    // Transform:
    const result = xsltPrs.transformToFragment(xml, document);
    document.getElementById('result_output').appendChild(result);

    const serializer = new XMLSerializer();
    console.log(serializer.serializeToString(result));
    //download('output.txt', serializer.serializeToString(result));
}

function download(filename, data) {
    var blob = new Blob([data], { type: 'text/xml' });
    if (window.navigator.msSaveOrOpenBlob) {
        window.navigator.msSaveBlob(blob, filename);
    }
    else {
        var elem = window.document.createElement('a');
        elem.href = window.URL.createObjectURL(blob);
        elem.download = filename;
        document.body.appendChild(elem);
        elem.click();
        document.body.removeChild(elem);
    }
}