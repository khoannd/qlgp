function convertDateObjectToString(oDate) {
    return oDate.getDate() + "/" + (oDate.getMonth() + 1) + "/" + oDate.getFullYear();
}
function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function validateUrl(url) {
    var ru = /((([A-Za-z]{3,9}:(?:\/\/)?)(?:[\-;:&=\+\$,\w]+@)?[A-Za-z0-9\.\-]+|(?:(www)?\.|[\-;:&=\+\$,\w]+@)[A-Za-z0-9\.\-]+)((?:\/[\+~%\/\.\w\-_]*)?\??(?:[\-\+=&;%@\.\w_]*)#?(?:[\.\!\/\\\w]*))?)/;
    return ru.test(url);
}

function makeScrollForModal() {
    $("body").addClass("modal-open");
}
function removeScrollForModal() {
    $("body").removeClass("modal-open");
}
function isDate(date) {
    var currVal = date;

    if (currVal == "") {
        return 0;
    }
    //Declare Regex
    var rxDatePattern = /^((\d{1,2})(\/))?((\d{1,2})(\/))?(\d{4})$/;

    var dtArray = currVal.match(rxDatePattern); // is format OK       

    if (dtArray == null) {
        return -1;
    }

    //Checks for dd/mm/yyyy format.
    var dtDay;
    var dtMonth;

    if (dtArray[4] && dtArray[5] && dtArray[6]) {
        dtDay = dtArray[2];
        dtMonth = dtArray[5];
    } else {
        dtMonth = dtArray[2];
    }
    var dtYear = dtArray[7];

    if (dtMonth) {
        if (dtMonth < 1 || dtMonth > 12) {
            return -2;
        }
    }
    if (dtDay) {
        if (dtDay < 1 || dtDay > 31) {
            return -2;
        }
    }
    if (dtDay && dtMonth) {
        if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31) {
            return -2;
        }
        if (dtMonth == 2) {
            var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));

            if (dtDay > 29 || (dtDay == 29 && !isleap)) {
                return -2;
            }
        }
    }
    return 1;
}

function showMessage(message, type, time) {
    if (type == '0') {
        $.gritter.add({
            title: 'Lỗi',
            text: message,
            class_name: 'gritter-error', //+ ' gritter-light'
            fade_in_speed: 'slow', // how fast notifications fade in (string or int)
            fade_out_speed: 150, // how fast the notices fade out
            time: (time ? time : 4000) // hang on the screen for...
        });
    } else if (type == '1') {
        $.gritter.add({
            title: 'Thành công',
            text: message,
            class_name: 'gritter-success', //+ ' gritter-light'
            fade_in_speed: 'slow', // how fast notifications fade in (string or int)
            fade_out_speed: 150, // how fast the notices fade out
            time: (time ? time : 4000) // hang on the screen for...
        });
    } else if (type == '-1') {
        $.gritter.add({
            title: 'Thông tin',
            text: message,
            class_name: 'gritter-info', //+ ' gritter-light'
            fade_in_speed: 'slow', // how fast notifications fade in (string or int)
            fade_out_speed: 150, // how fast the notices fade out
            time: (time ? time : 4000) // hang on the screen for...
        });
    }

    $(".gritter-close").css({ "margin-left": "90%" });
    //  $.gritter.removeAll();
}

function convertPosition(id) {
    if (id == "1") {
        return "Chủ hộ";
    } else if (id == "2") {
        return "Chồng";
    } else if (id == "3") {
        return "Vợ";
    } else if (id == "4") {
        return "Con";
    } else if (id == "5") {
        return "Cháu";
    } else if (id == "6") {
        return "Cha";
    } else if (id == "7") {
        return "Mẹ";
    } else if (id == "8") {
        return "Ông";
    } else if (id == "9") {
        return "Bà";
    } else if (id == "10") {
        return "Anh";
    } else if (id == "11") {
        return "Chị";
    } else if (id == "12") {
        return "Em";
    } else if (id == "13") {
        return "Dâu";
    } else if (id == "14") {
        return "Rể";
    } else if (id == "15") {
        return "Cô";
    } else if (id == "16") {
        return "Chú";
    } else if (id == "17") {
        return "Bác";
    } else if (id == "18") {
        return "Cậu";
    } else if (id == "19") {
        return "Dì";
    } else if (id == "20") {
        return "Mợ";
    } else if (id == "21") {
        return "Thím";
    } else if (id == "22") {
        return "Dượng";
    } else {
        return "Chưa rõ";
    }
}

function startLoading() {
    $("#loading").fadeIn();
}

function updateTableContent(id) {
    try {
        $("#" + id).dataTable()._fnPageChange(0);
        $("#" + id).dataTable()._fnAjaxUpdate();
    }
    catch (e) {
        $("#loading").fadeOut();
    }

}

function convertStringToDate(date) {
    if (!date) {
        return "";
    }

    date = date.trim();

    if (!date) {
        return "";
    }

    var year = date.substring(0, 4);
    var month = date.substring(4, 6);
    var day = date.substring(6, 8);

    var result = "";

    if (day != "00") {
        result += day + "/";
    }

    if (month != "00") {
        result += month + "/";
    }

    result += year;

    return result;
}

function convertDateToString(date) {
    var day;
    var month;
    var year;

    if (!date) {
        return "";
    }

    var dateParts = date.split('/');

    if (dateParts.length == 3) {
        day = convertStringForDateAndMonth(dateParts[0]);
        month = convertStringForDateAndMonth(dateParts[1]);
        year = dateParts[2];
    } else if (dateParts.length == 2) {
        day = "00";
        month = convertStringForDateAndMonth(dateParts[0]);
        year = dateParts[1];
    }
    else if (dateParts.length == 1) {
        day = "00";
        month = "00";
        year = dateParts[0];
    }
    else {
        return "";
    }

    return year + month + day;
}

function convertStringForDateAndMonth(s) {
    var result;

    if (s.length == 1) {
        result = "0" + s;
    }
    else {
        result = s;
    }

    return result;
}
// Khoan add start
var term = '';
function autocomplete(selector, url, selectedCallback, renderCallback) {
    var cache = {}, lastXhr;
    $(selector).autocomplete({
        minLength: 2,
        delay: 700,
        source: function (request, response) {
            term = $.trim(request.term);
            if (term in cache) {
                if (cache[term]) {
                    response(cache[term]); $(selector).removeClass("ui-autocomplete-loading");
                    return;
                }
            }
            lastXhr = $.getJSON(url, { name: term }, function (data, status, xhr) {
                $(selector).removeClass("ui-autocomplete-loading");
                cache[term] = data.result;
                if (xhr === lastXhr) { response(data.result); }
            });
        },
        select: function (event, ui) {
            if (selectedCallback) {
                selectedCallback(ui.item);
                return false;
            }
        },
        change: function (event, ui) {
            // processing when text change
        },
        create: function (event, ui) {
            
        },
        open: function (event, ui) {

        }
    }).focus(function () {
        if ($(selector).val() == term) {
            $(selector).autocomplete("search");
        }
    }).autocomplete("instance")._renderItem = function (ul, item) {
        if (renderCallback) {
            return renderCallback(ul, item);
        }
        else {
            // create html for each dropdown item
            var dropdownItem = $("<li></li>")
                    .data("item.autocomplete", item) // store data in the item
                    .append("<a>" + (item.ChristianName ? item.ChristianName + " " : "") + item.Name + (item.BirthDate ? ", NS: " + item.BirthDate : "") + "</a>") // can add more properties such as prarish name, gender,...
                    .appendTo(ul);
            return dropdownItem;
        }
    };
}
// Khoan add end