function getOfficer(officer_id, officer_select, ServetName) {
    console.log("getting officer");
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            if (this.responseText.includes('option')) {
                console.log("got response for officer");
                document.getElementById(officer_select).innerHTML = this.responseText;

                if (document.getElementById(officer_select).length > 1) {
                    document.getElementById(officer_select).removeAttribute("disabled");
                }
            }
            else {
                console.log("got errror response for officer");
            }

        }
        else if (this.readyState == 4 && this.status != 200) {
            alert('failed ' + this.status);
        }
    };
    xhttp.open("POST", ServetName + "?actionType=getGRSOffice&officer_id=" + officer_id, true);
    xhttp.send();
}

function getLayer(layernum, layerID, childLayerID, selectedValue, ServetName) {
    console.log("getting layer");
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            if (this.responseText.includes('option')) {
                console.log("got response");
                document.getElementById(childLayerID).innerHTML = this.responseText;
            }
            else {
                console.log("got errror response");
            }

        }
        else if (this.readyState == 4 && this.status != 200) {
            alert('failed ' + this.status);
        }
    };
    xhttp.open("POST", ServetName + "?actionType=getGRSLayer&layernum=" + layernum + "&layerID="
        + layerID + "&childLayerID=" + childLayerID + "&selectedValue=" + selectedValue, true);
    xhttp.send();
}


function layerselected(layernum, layerID, childLayerID, hiddenInput, hiddenInputForTopLayer, officerElement, ServetName) {
    var layervalue = document.getElementById(layerID).value;
    console.log("layervalue = " + layervalue);
    document.getElementById(hiddenInput).value = layervalue;
    if (layernum == 0) {
        document.getElementById(hiddenInputForTopLayer).value = layervalue;
    }
    if (layernum == 0 || (layernum == 1 && document.getElementById(hiddenInputForTopLayer).value == 3)) {
        document.getElementById(childLayerID).setAttribute("style", "display: inline;");
        getLayer(layernum, layerID, childLayerID, layervalue, ServetName);
    }

    if (officerElement !== null) {
        getOfficer(layervalue, officerElement, ServetName);
    }

}

function isNumeric(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
}

function addHTML(id, HTML) {
    document.getElementById(id).innerHTML += HTML;
}

function getRequests() {
    var s1 = location.search.substring(1, location.search.length).split('&'),
        r = {}, s2, i;
    for (i = 0; i < s1.length; i += 1) {
        s2 = s1[i].split('=');
        r[decodeURIComponent(s2[0]).toLowerCase()] = decodeURIComponent(s2[1]);
    }
    return r;
}

function Request(name) {
    return getRequests()[name.toLowerCase()];
}

function ShowExcelParsingResult(suffix) {
    var failureMessage = document.getElementById("failureMessage_" + suffix);
    if (failureMessage == null) {
        console.log("failureMessage_" + suffix + " not found");
    }
    console.log("value = " + failureMessage.value);
    if (failureMessage != null && failureMessage.value != "") {
        alert("Excel uploading result:" + failureMessage.value);
    }
}

function removeElement(elementId) {
    // Removes an element from the document
    var element = document.getElementById(elementId);
    element.parentNode.removeChild(element);
}

function approve(row_id, successMessage, i, ServletName) {
    console.log("approving");
    //removeElement("approve_" + row_id);
    var element = document.getElementById("tdapprove_" + row_id);
    var edit = document.getElementById(i + "_Edit");
    var cb_td = document.getElementById(i + "_checkbox");
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            element.innerHTML = successMessage;
            edit.innerHTML = "";
            cb_td.innerHTML = "";
        }
        else if (this.readyState == 4 && this.status != 200) {
            element.innerHTML = "Approval Failed";
            alert('failed ' + this.status);
        }
    };
    xhttp.open("POST", ServletName + "?actionType=approve&idToApprove=" + row_id, true);
    xhttp.send();
}


function doEdit(params, i, id, deletedStyle, isPermanentTable, ServletName) {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            if (this.responseText != '') {
                var onclickFunc = "submitAjax(" + i + ",'" + deletedStyle + "')";
                document.getElementById('tr_' + i).innerHTML = this.responseText;

                document.getElementById('tr_' + i).innerHTML += "<td id = '" + i + "_Submit'></td>";

                if (document.getElementById('isPermanentTable').value !== 'true') {
                    document.getElementById('tr_' + i).innerHTML += "<td></td><td></td><td></td>";
                }
                document.getElementById(i + '_Submit').innerHTML += "<button class=\"btn btn-primary btn-hover-brand btn-square\" onclick=\"" + onclickFunc + "\">" + inplaceSubmitButton + "</button>";
                document.getElementById('tr_' + i).innerHTML += "<td>"
                    + "<div >"
                    + "<label class='kt-checkbox kt-checkbox--brand' id='chkEdit'><input type='checkbox' class='checkbox' name='ID' value='" + id + "'/><span></span></label>"
                    + "</td>";
                init(i);
                select_2_call();
            }
            else {
                document.getElementById('tr_' + i).innerHTML = 'NULL RESPONSE';
            }
        }
        else if (this.readyState == 4 && this.status != 200) {
            alert('failed ' + this.status);
        }
    };

    xhttp.open("Get", ServletName + "?isPermanentTable=" + isPermanentTable + "&actionType=getEditPage" + params, true);
    xhttp.send();
}

function fixedToEditable(i, deletedStyle, id, isPermanentTable, ServletName) {
    console.log('fixedToEditable called....., isPermanentTable = ' + isPermanentTable, i, id, ServletName);
    var params = '&identity=' + id + '&inplaceedit=true' + '&deletedStyle=' + deletedStyle + '&ID=' + id + '&rownum=' + i
        + '&dummy=dummy';
    console.log('fixedToEditable i = ' + i + ' id = ' + id);
    doEdit(params, i, id, deletedStyle, isPermanentTable, ServletName);

}

function SetCheckBoxValues(tablename) {
    var i = 0;
    console.log("document.getElementById(tablename).childNodes.length = " + document.getElementById(tablename).childNodes.length);
    var element = document.getElementById(tablename);

    var j = 0;
    for (i = 0; i < document.getElementById(tablename).childNodes.length; i++) {
        var tr = document.getElementById(tablename).childNodes[i];
        if (tr.nodeType === Node.ELEMENT_NODE) {
            console.log("tr.childNodes.length= " + tr.childNodes.length);
            var checkbox = tr.querySelector('input[type="checkbox"]');
            checkbox.id = tablename + "_cb_" + j;
            j++;
        }

    }
}

function select_2_call() {
    console.log('select2 ---------------------------- call')
    $("select").select2({
        dropdownAutoWidth: true
    });
}