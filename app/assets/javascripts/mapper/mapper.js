/*global window */
$(document).ready(function() {
    r = Raphael("bubble-map", 940, 480);
    connections = [];
    shapes = [];
    shapes = [  
        r.rect(370, 10, 200, 40, 10).attr({cursor: "pointer"}),   // [0] = name
        r.rect(1, 310, 340, 150, 10).attr({cursor: "pointer"}),   // [1] = twitter box
        r.rect(370, 80, 200, 200, 10).attr({cursor: "pointer"}),  // [2] = picture
        r.rect(370, 309, 200, 150, 10).attr({cursor: "pointer"}), // [3] = details
        r.rect(180, 30, 100, 45, 10).attr({cursor: "pointer"}),   // [4] = professional experience
        r.rect(200, 170, 100, 45, 10).attr({cursor: "pointer"}),  // [5] = controversy
        r.rect(180, 245, 100, 45, 10).attr({cursor: "pointer"}),  // [6] = issue positions
        r.rect(600, 200, 100, 45, 10).attr({cursor: "pointer"}),  // [7] = political offices
        r.rect(35, 1, 100, 45, 10).attr({cursor: "pointer"}),     // [8] = family network
        r.rect(13, 70, 100, 45, 10).attr({cursor: "pointer"}),    // [9] = investments
        r.rect(5, 140, 100, 45, 10).attr({cursor: "pointer"}),    // [10] = net worth
        r.rect(155, 100, 100, 45, 10).attr({cursor: "pointer"}),  // [11] = accusations
        r.rect(80, 200, 100, 45, 10).attr({cursor: "pointer"}),   // [12] = litigation
        r.rect(620, 300, 100, 45, 10).attr({cursor: "pointer"}),  // [13] = voting behavior
        r.rect(760, 315, 100, 45, 10).attr({cursor: "pointer"}),  // [14] = earmarks
        r.rect(780, 400, 100, 45, 10).attr({cursor: "pointer"}),  // [15] = co-sponsored
        r.rect(630, 380, 100, 45, 10).attr({cursor: "pointer"}),  // [16] = sponsored
        r.rect(735, 250, 100, 45, 10).attr({cursor: "pointer"}),  // [17] = committees
        r.rect(750, 180, 100, 45, 10).attr({cursor: "pointer"}),  // [18] = campaign platforms
        r.rect(780, 120, 100, 45, 10).attr({cursor: "pointer"}),  // [19] = flip flops
        r.rect(640, 90, 100, 45, 10).attr({cursor: "pointer"}),   // [20] = contributors
        r.rect(805, 50, 100, 45, 10).attr({cursor: "pointer"}),   // [21] = PACs
        r.rect(700, 5, 100, 45, 10).attr({cursor: "pointer"})    // [22] = demographics & endorsements
    ];

    nodeTexts = ["Professional\n experience", "Controversy", "Issue Positions", "Political Offices", "Family Network", "Investments", "Net Worth", "Accusations", "Litigation", "Voting Behavior", "Earmarks", "Co-sponsored", "Sponsored\n Legislation", "Committees", "Campaign\nPlatforms", "Flip flops", "Contributors", "PACs", "Demographics &\n Endorsements"];
    ajaxPartials = ["professional_experience_text", "controversy_text", "issue_positions_text", "political_offices_text", "family_network_text", "investments_text", "net_worth_text", "accusations_text", "litigation_text", "voting_behavior_text", "earmarks_text", "cosponsored_legislation_text", "sponsored_legislation_text", "committees_text", "campaign_platforms_text", "flip_flops_text", "contributors_text", "pacs_text", "demographics_and_endorsements_text"];

    function hoverIn() {
        // this.attr({stroke: "#000"});
    }
    function hoverOut() {
        // this.attr({stroke: "#BBB"});
    }

    i = 0;
    for (shape in shapes) {
        texts = [];
        if (i < 4) {
            // do nothing
        } else if (i == 5) {
            // non-clickable!
            sx = shapes[i].attrs.x + 50;
            sy = shapes[i].attrs.y + 23;
            r.text(sx, sy, nodeTexts[i - 4]).attr({"font-size": "12px"});
        } else if ((i == 13 || i == 14 || i == 15 || i == 16 || i == 17) && (window.congressmember == "false")) {
            sx = shapes[i].attrs.x + 50;
            sy = shapes[i].attrs.y + 23;
            texts[i] = r.text(sx, sy, nodeTexts[i - 4]).attr({
                fill: "#999",
                "font-size": "12px"
            });
            texts[i].node.onclick = function() {
            }
        } else {
            sx = shapes[i].attrs.x + 50;
            sy = shapes[i].attrs.y + 23;
            texts[i] = r.text(sx, sy, nodeTexts[i - 4]).attr({"font-size": "12px", cursor: "pointer"});
            texts[i].node.onclick = function() {
                newRect = makeRectBlank();
                n = 23;
                while (n < 46) {
                    if (n == this.raphaelid) {
                        var xhr = $.ajax({
                            type: "GET",
                            url: 'refresh_bubble_rect',
                            dataType: "script",
                            data: { pid: window.pid, 
                                    nytid: window.nytid, 
                                    partial_name: ajaxPartials[n - 23]
                            },
                            success: function() {
                                loader.hide();
                                $('#data-table').dataTable({
                                    sPaginationType: "full_numbers",
                                    bLengthChange: false,
                                    bJQueryUI: true
                                });
                            }
                        });
                    }
                    n = n + 1;
                }
                newRect.node.onclick = function() {
                    xhr.abort();
                    loader.hide();
                    newRect.hide();
                    $('#popup-text').hide();
                    if (window.twitter_id == "") {
                        tb_error = r.text(65, 345, "Could not load feed.").attr({"font-size": "24px", "text-anchor": "start", fill: "#999"});
                        $('#follow-button').hide();
                    } else {
                        $('#current-tweet').show();
                        $('#follow-button').show();
                    }
                    closeButton.hide();
                    closeButtonText.hide();
                    pie.hide();
                }
            }
            shapes[i].mouseover(hoverIn);
            shapes[i].mouseout(hoverOut);
            shapes[i].node.onclick = function() {
                // make rectangle
                newRect = makeRectBlank();
                // get ajax based on what node we are in
                n = 0
                while (n < 23) {
                    if (n == this.raphaelid) {
                        var xhr = $.ajax({
                            type: "GET",
                            url: 'refresh_bubble_rect',
                            dataType: "script",
                            data: { pid: window.pid, 
                                nytid: window.nytid, 
                                partial_name: ajaxPartials[n - 4]
                            },
                            success: function() {
                                loader.hide();
                                $('#data-table').dataTable({
                                    sPaginationType: "full_numbers",
                                    bLengthChange: false,
                                    bJQueryUI: true
                                });
                            }
                        });
                    }
                    n = n + 1;
                }
                newRect.node.onclick = function() {
                    xhr.abort();
                    loader.hide();
                    newRect.hide();
                    $('#popup-text').hide();
                    if (window.twitter_id == "") {
                        tb_error = r.text(65, 345, "Could not load feed.").attr({"font-size": "24px", "text-anchor": "start", fill: "#999"});
                        $('#follow-button').hide();
                    } else {
                        $('#current-tweet').show();
                        $('#follow-button').show();
                    }
                    closeButton.hide();
                    closeButtonText.hide();
                    pie.hide();
                }
            }
        }
        i = i + 1;
    }

    // this is the loop we need to change main node colors to darker grey
    for (var i = 0, ii = shapes.length; i < ii; i++) {
        if (window.congressmember == "false") {
            if (i == 5) {
                shapes[i].attr({
                    fill: "#CCC",
                    stroke: "#BBB",
                    "fill-opacity": 1, 
                    "stroke-width": 3
                });
                shapes[i].node.onclick = function() {
                    shapes[11].attr({
                        stroke: "red"
                    });
                    shapes[12].attr({
                        stroke: "blue"
                    });
                } 
            } else if (i == 13 || i == 14  || i == 15 || i == 16 || i == 17) {
                shapes[i].attr({
                    fill: "#EEE",
                    stroke: "#AAA",
                    "fill-opacity": 1
                });
                shapes[i].node.onclick = function() {
                }
            } else if (i == 1) {
                shapes[i].attr({
                    stroke: "#BBB",
                    "fill": "#FFF",
                    "stroke-width": 3
                });
            } else {
                shapes[i].attr({
                    fill: "#EEE", 
                    stroke: "#BBB", 
                    "fill-opacity": 1, 
                    "stroke-width": 3
                });
            }
        } else {
            if (i == 5) {
                shapes[i].attr({
                    fill: "#CCC",
                    stroke: "#BBB",
                    "fill-opacity": 1, 
                    "stroke-width": 3
                });
                shapes[i].node.onclick = function() {
                    shapes[11].attr({
                        stroke: "red"
                    });
                    shapes[12].attr({
                        stroke: "blue"
                    });
                } 
            } else if (i == 1) {
                shapes[i].attr({
                    stroke: "#BBB",
                    "fill": "#FFF",
                    "stroke-width": 3
                });
            } else {
                shapes[i].attr({
                    fill: "#EEE", 
                    stroke: "#BBB", 
                    "fill-opacity": 1, 
                    "stroke-width": 3
                });
            }
        }
    }
    // image
    if (window.photo_url != undefined) {
        var personImage = window.photo_url
        r.image(personImage, 369, 59, 202, 240)
    }

    // main-infotabs
    if (window.state_represented != "" && window.chamber == "H") {
        r.text(380, 30, full_name + " (" + current_party + ") " + state_represented + "-" +  district).attr({"font-size": "13px", "text-anchor": "start"});
    } else if (window.chamber == "S") {
        r.text(380, 30, full_name + " (" + current_party + ") " + state_represented).attr({"font-size": "13px", "text-anchor": "start"}); 
    } else {
        r.text(382, 30, full_name).attr({"font-size": "14px", "text-anchor": "start"});
    }
    if (window.birthplace != "") {
        r.text(382, 320, "Birthplace: " + birthplace).attr({"text-anchor": "start", "font-size": "12px"});
    } else {
        r.text(382, 320, "Birthplace: Unknown" + birthplace).attr({"text-anchor": "start", "font-size": "12px"});
    }
    if (window.birthdate != "") {
        r.text(382, 335, "Born: " + birthdate).attr({"text-anchor": "start", "font-size": "12px"});
    } else {
        r.text(382, 335, "Birthdate: Unknown").attr({"text-anchor": "start", "font-size": "12px"});
    }

    // set up split-lines for religion
    var maxWidth = 190;
    var religionText = religion;
    if (religionText.length < 20) {
        religionInfo = r.text(382, 350, "Religion: " + religionText).attr({"text-anchor": "start", "font-size": "12px"});
    } else {
        var religionWords = religion.split(" ");
        religionInfo = r.text(382, 355).attr({"text-anchor": "start", "font-size": "12px"});

        var religionTempText = "Religion: ";
        for (var i=0; i < religionWords.length; i++) {
            religionInfo.attr("text", religionTempText + " " + religionWords[i]);
            if (religionInfo.getBBox().width > maxWidth) {
                religionTempText += "\n" + religionWords[i];
            } else {
                religionTempText += " " + religionWords[i];
            }
        }
        religionInfo.attr("text", religionTempText.substring(0));
    }

    eduRect = r.rect(380, 370, 170, 15, 5).attr({stroke: "none", fill: "red", cursor: "pointer"});
    eduRectText = r.text(425, 378, "EDUCATION").attr({fill: "#FFF", "font-size": 12, "font-weight": "100", cursor: "pointer"});
    litRect = r.rect(380, 390, 170, 15, 5).attr({stroke: "none", fill: "red", cursor: "pointer"});
    litRectText = r.text(443, 398, "LITERARY WORKS").attr({fill: "#FFF", "font-size": 12, "font-weight": "100", cursor: "pointer"});
    litRectStar = r.image(star, 500, 390, 17, 15).toFront().attr({cursor: "pointer"});
    orgRect = r.rect(380, 410, 170, 15, 5).attr({stroke: "none", fill: "red", cursor: "pointer"});
    orgRectText = r.text(438, 418, "ORGANIZATIONS").attr({fill: "#FFF", "font-size": 12, "font-weight": "100", cursor: "pointer"});
    contactRect = r.rect(380, 430, 170, 15, 5).attr({stroke: "none", fill: "red", cursor: "pointer"});
    contactRectText = r.text(419, 438, "CONTACT").attr({fill: "#FFF", "font-size": 12, "font-weight": "100", cursor: "pointer"});

    // main-infotabs listeners
    eduRect.node.onclick = function() {
        makeRect("education_text");
    }
    eduRectText.node.onclick = function() {
        makeRect("education_text");
    }
    litRect.node.onclick = function() {
        makeRect("literary_works_text");
    }
    litRectText.node.onclick = function() {
        makeRect("literary_works_text");
    }
    litRectStar.node.onclick = function() {
        makeRect("literary_works_text");
    }
    orgRect.node.onclick = function() {
        makeRect("organizations_text");
    }
    orgRectText.node.onclick = function() {
        makeRect("organizations_text");
    }
    contactRect.node.onclick = function() {
        makeRect("contact_text");
    }
    contactRectText.node.onclick = function() {
        makeRect("contact_text");
    }

    // twitterbox
    function Twitterbox() {
        this.callback = generateCallback();
        this.timeline;

        if (window.twitter_id == "") {
            tb_error = r.text(65, 345, "Could not load feed.").attr({"font-size": "24px", "text-anchor": "start", fill: "#999"});
            $('#follow-button').hide();
        } else {
            function getUser() {
                return $.ajax({
                    type: "GET",
                    url: "https://api.twitter.com/1/users/lookup.json",
                    dataType: "jsonp",
                    data: { screen_name: twitter_id, callback: this.callback },
                    success: function(data) {
                        $('#follow-button').show();
                        return data;
                    }
                });
            }

            function getTimeline() {
                return $.ajax({
                    type: "GET",
                    url: "https://api.twitter.com/1/statuses/user_timeline.json",
                    dataType: "jsonp",
                    data: { screen_name: twitter_id, callback: this.callback },
                    success: function(timeline) {
                        return timeline;
                    }
                });
            }

            userPromise = getUser();
            userPromise.success(function(data) {
                img = data[0]['profile_image_url'].toString();
                tb_profile_link = "http://www.twitter.com/" + twitter_id;
                tb_img = r.image(img, 10, 325, 48, 48).attr({href: tb_profile_link});
                tb_name = r.text(65, 330, data[0]['name']).attr({"font-size": "14px", "text-anchor": "start", fill: "#444", href: tb_profile_link });
                tb_screen_name = r.text(65, 345, "@" + twitter_id).attr({"font-size": "12px", "text-anchor": "start", fill: "#9F1D21", href: tb_profile_link });
            });

            timelinePromise = getTimeline();
            var i = 0;
            timelinePromise.success(function(timeline) {
                // most-current tweet
                $('#current-tweet').html('<p class="tweet-date">' + timeline[i]['created_at'] + '</p>' +'<p class="tweet-content">' + timeline[i]['text'] + '</p>');

                // controls
                twitter_right_arrow = r.image('/assets/twitter_right_arrow.png', 310, 430, 25, 25).attr({cursor: "pointer"});
                twitter_left_arrow = r.image('/assets/twitter_left_arrow.png', 280, 430, 25, 25).attr({cursor: "pointer"});
                twitter_right_arrow.node.onclick = function() {
                    i = i + 1; 
                    if (timeline[i] == undefined) {
                        i = i - 1;
                    } else {
                        $('#current-tweet').html('<p class="tweet-date">' + timeline[i]['created_at'] + '</p>' + '<p class="tweet-content">' + timeline[i]['text'] + '</p>');
                    }
                }
                twitter_left_arrow.node.onclick = function() {
                    i = i - 1; 
                    if (timeline[i] == undefined) {
                        i = i + 1;
                    } else {
                        $('#current-tweet').html('<p class="tweet-date">' + timeline[i]['created_at'] + '</p>' + '<p class="tweet-content">' + timeline[i]['text'] + '</p>');
                    }
                }
            });
        }
    }
    tb = new Twitterbox();

    // connections
    connections.push(r.connection(shapes[2], shapes[4], "#444"));
    connections.push(r.connection(shapes[2], shapes[5], "#444"));
    connections.push(r.connection(shapes[2], shapes[6], "#444"));
    connections.push(r.connection(shapes[2], shapes[7], "#444"));
    connections.push(r.connection(shapes[4], shapes[8], "#444"));
    connections.push(r.connection(shapes[4], shapes[9], "#444"));
    connections.push(r.connection(shapes[9], shapes[10], "#444"));
    connections.push(r.connection(shapes[5], shapes[11], "#444"));
    connections.push(r.connection(shapes[5], shapes[12], "#444"));
    connections.push(r.connection(shapes[7], shapes[17], "#444"));
    connections.push(r.connection(shapes[7], shapes[13], "#444"));
    connections.push(r.connection(shapes[7], shapes[18], "#444"));
    connections.push(r.connection(shapes[7], shapes[20], "#444"));
    connections.push(r.connection(shapes[13], shapes[14], "#444"));
    connections.push(r.connection(shapes[13], shapes[16], "#444"));
    connections.push(r.connection(shapes[16], shapes[15], "#444"));
    connections.push(r.connection(shapes[20], shapes[21], "#444"));
    connections.push(r.connection(shapes[20], shapes[22], "#444"));
    connections.push(r.connection(shapes[18], shapes[19], "#444"));
});

function makeRect(partial) {
    // instantiate objects
    newRect = r.rect(0, 0, 940, 480).attr({ 
        fill: "#FFF",
        stroke: "#BBB",
        "stroke-width": 3,
        cursor: "pointer"
    });
    $('#follow-button').hide();
    $('#current-tweet').hide();
    loader = r.image('../assets/ajax-loader.gif', 450, 210, 40, 40);
    closeButton = r.rect(10, 10, 100, 20).attr({fill: "#9F1D21"})
    closeButtonText = r.text(23, 20, "<< BACK").attr({"font-size": "16px", "text-anchor": "start", fill: "#FFF", cursor: "pointer"});
    // get data
    var xhr = $.ajax({
        type: "GET",
        url: 'refresh_bubble_rect',
        dataType: "script",
        data: { pid: window.pid, 
            nytid: window.nytid, 
            partial_name: partial
        }, 
        success: function() {
            loader.hide();
        }
    });

    // setup listeners
    newRect.node.onclick = function() {
        xhr.abort();
        loader.hide();
        $('#popup-text').hide();
        if (window.twitter_id == "") {
            tb_error = r.text(65, 345, "Could not load feed.").attr({"font-size": "24px", "text-anchor": "start", fill: "#999"});
            $('#follow-button').hide();
        } else {
            $('#current-tweet').show();
            $('#follow-button').show();
        }
        newRect.hide();
        closeButton.hide();
        closeButtonText.hide();
        pie.hide();
    }
    closeButton.node.onclick = function() {
        xhr.abort();
        loader.hide();
        $('#popup-text').hide();
        $('#popup-text').hide();
        if (window.twitter_id == "") {
            tb_error = r.text(65, 345, "Could not load feed.").attr({"font-size": "24px", "text-anchor": "start", fill: "#999"});
            $('#follow-button').hide();
        } else {
            $('#current-tweet').show();
            $('#follow-button').show();
        }
        newRect.hide();
        closeButton.hide();
        closeButtonText.hide();
        pie.hide();
    }
    closeButtonText.node.onclick = function() {
        xhr.abort();
        loader.hide();
        $('#popup-text').hide();
        if (window.twitter_id == "") {
            tb_error = r.text(65, 345, "Could not load feed.").attr({"font-size": "24px", "text-anchor": "start", fill: "#999"});
            $('#follow-button').hide();
        } else {
            $('#current-tweet').show();
            $('#follow-button').show();
        }
        newRect.hide();
        closeButton.hide();
        closeButtonText.hide();
        pie.hide();
    }
    return newRect;
}

function makeRectBlank() {
    newRect = r.rect(0, 0, 940, 480).attr({ 
        fill: "#FFF",
        stroke: "#BBB",
        "stroke-width": 3,
        cursor: "pointer"
    });
    $('#follow-button').hide();
    $('#current-tweet').hide();
    loader = r.image('../assets/ajax-loader.gif', 450, 210, 40, 40);
    closeButton = r.rect(10, 10, 100, 20).attr({fill: "#9F1D21"})
    closeButtonText = r.text(23, 20, "<< BACK").attr({"font-size": "16px", "text-anchor": "start", fill: "#FFF", cursor: "pointer"});
    newRect.node.onclick = function() {
        if (typeof xhr != 'undefined') {
            xhr.abort();
        }
        loader.hide();
        $('#popup-text').hide();
        if (window.twitter_id == "") {
            tb_error = r.text(65, 345, "Could not load feed.").attr({"font-size": "24px", "text-anchor": "start", fill: "#999"});
            $('#follow-button').hide();
        } else {
            $('#current-tweet').show();
            $('#follow-button').show();
        }
        newRect.hide();
        closeButton.hide();
        closeButtonText.hide();
        pie.hide();
    }
    closeButton.node.onclick = function() {
        if (typeof xhr != 'undefined') {
            xhr.abort();
        }
        loader.hide();
        $('#popup-text').hide();
        if (window.twitter_id == "") {
            tb_error = r.text(65, 345, "Could not load feed.").attr({"font-size": "24px", "text-anchor": "start", fill: "#999"});
            $('#follow-button').hide();
        } else {
            $('#current-tweet').show();
            $('#follow-button').show();
        }
        newRect.hide();
        closeButton.hide();
        closeButtonText.hide();
        pie.hide();
    }
    closeButtonText.node.onclick = function() {
        if (typeof xhr != 'undefined') {
            xhr.abort();
        }
        loader.hide();
        $('#popup-text').hide();
        if (window.twitter_id == "") {
            tb_error = r.text(65, 345, "Could not load feed.").attr({"font-size": "24px", "text-anchor": "start", fill: "#999"});
            $('#follow-button').hide();
        } else {
            $('#current-tweet').show();
            $('#follow-button').show();
        }
        newRect.hide();
        closeButton.hide();
        closeButtonText.hide();
        pie.hide();
    }
    return newRect;
}

function generateCallback() {
    randomNumber = Math.random() * 10000000000;
    callback = Math.floor(randomNumber);
    return callback;
}

Raphael.fn.connection = function (obj1, obj2, line, bg) {
    if (obj1.line && obj1.from && obj1.to) {
        line = obj1;
        obj1 = line.from;
        obj2 = line.to;
    }
    var bb1 = obj1.getBBox(),
    bb2 = obj2.getBBox(),
    p = [{x: bb1.x + bb1.width / 2, y: bb1.y - 1},
        {x: bb1.x + bb1.width / 2, y: bb1.y + bb1.height + 1},
        {x: bb1.x - 1, y: bb1.y + bb1.height / 2},
        {x: bb1.x + bb1.width + 1, y: bb1.y + bb1.height / 2},
        {x: bb2.x + bb2.width / 2, y: bb2.y - 1},
        {x: bb2.x + bb2.width / 2, y: bb2.y + bb2.height + 1},
        {x: bb2.x - 1, y: bb2.y + bb2.height / 2},
    {x: bb2.x + bb2.width + 1, y: bb2.y + bb2.height / 2}],
    d = {}, dis = [];
    for (var i = 0; i < 4; i++) {
        for (var j = 4; j < 8; j++) {
            var dx = Math.abs(p[i].x - p[j].x),
            dy = Math.abs(p[i].y - p[j].y);
            if ((i == j - 4) || (((i != 3 && j != 6) || p[i].x < p[j].x) && ((i != 2 && j != 7) || p[i].x > p[j].x) && ((i != 0 && j != 5) || p[i].y > p[j].y) && ((i != 1 && j != 4) || p[i].y < p[j].y))) {
                dis.push(dx + dy);
                d[dis[dis.length - 1]] = [i, j];
            }
        }
    }
    if (dis.length == 0) {
        var res = [0, 4];
    } else {
        res = d[Math.min.apply(Math, dis)];
    }
    var x1 = p[res[0]].x,
    y1 = p[res[0]].y,
    x4 = p[res[1]].x,
    y4 = p[res[1]].y;
    dx = Math.max(Math.abs(x1 - x4) / 2, 10);
    dy = Math.max(Math.abs(y1 - y4) / 2, 10);
    var x2 = [x1, x1, x1 - dx, x1 + dx][res[0]].toFixed(3),
    y2 = [y1 - dy, y1 + dy, y1, y1][res[0]].toFixed(3),
    x3 = [0, 0, 0, 0, x4, x4, x4 - dx, x4 + dx][res[1]].toFixed(3),
    y3 = [0, 0, 0, 0, y1 + dy, y1 - dy, y4, y4][res[1]].toFixed(3);
    var path = ["M", x1.toFixed(3), y1.toFixed(3), "C", x2, y2, x3, y3, x4.toFixed(3), y4.toFixed(3)].join(",");
    if (line && line.line) {
        line.bg && line.bg.attr({path: path});
        line.line.attr({path: path});
    } else {
        var color = typeof line == "string" ? line : "#000";
        return {
            bg: bg && bg.split && this.path(path).attr({stroke: bg.split("|")[0], fill: "none", "stroke-width": bg.split("|")[1] || 3}),
            line: this.path(path).attr({stroke: color, fill: "none"}),
            from: obj1,
            to: obj2
        };
    }
};

