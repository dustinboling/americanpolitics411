// attribution: graffle.js demo from the raphael.js site
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

window.onload = function() {
  r = Raphael("bubble-map", 940, 480),
  connections = [];
  shapes = [  r.rect(370, 40, 200, 40, 10),   // [0] = name
              r.rect(1, 310, 300, 150, 10),   // [1] = twitter box
              r.rect(370, 90, 200, 200, 10),  // [2] = picture
              r.rect(370, 300, 200, 160, 10), // [3] = details
              r.rect(180, 30, 100, 45, 10),   // [4] = professional experience
              r.rect(200, 170, 100, 45, 10) , // [5] = controversy
              r.rect(180, 245, 100, 45, 10),  // [6] = issue positions
              r.rect(600, 200, 100, 45, 10),  // [7] = political offices
              r.rect(35, 1, 100, 45, 10),     // [8] = family network
              r.rect(13, 70, 100, 45, 10),    // [9] = investments
              r.rect(5, 140, 100, 45, 10),    // [10] = net worth
              r.rect(155, 100, 100, 45, 10),  // [11] = accusations 
              r.rect(80, 200, 100, 45, 10),   // [12] = litigation
              r.rect(620, 290, 100, 45, 10),  // [13] = voting behavior
              r.rect(760, 300, 100, 45, 10),  // [14] = earmarks
              r.rect(780, 400, 100, 45, 10),  // [15] = co-sponsored
              r.rect(630, 380, 100, 45, 10),  // [16] = sponsored
              r.rect(735, 240, 100, 45, 10),  // [17] = committees
              r.rect(750, 180, 100, 45, 10),  // [18] = campaign platforms
              r.rect(780, 120, 100, 45, 10),  // [19] = flip flops
              r.rect(640, 90, 100, 45, 10),   // [20] = contributors
              r.rect(805, 50, 100, 45, 10),   // [21] = PACs
              r.rect(700, 5, 100, 45, 10)     // [22] = demographics & endorsements
          ];
  popupTexts = [professional_experience, "nothing", issue_positions, political_offices, family_network, investments, net_worth, accusations, litigation, "nothing", earmarks, "needs some ajax", "needs some ajax", "needs some ajax", campaign_platforms, flip_flops, "needs some ajax", "PAC's: needs some ajax", "Demographics/Endorsements: might need some ajax" ]; 
  nodeTexts = ["Professional\n experience", "Controversy", "Issue Positions", "Political Offices", "Family Network", "Investments", "Net Worth", "Accusations", "Litigation", "Voting Behavior", "Earmarks", "Co-sponsored", "Sponsored\n Legislation", "Committees", "Campaign Platforms", "Flip flops", "Contributors", "PACs", "Demographics &\n Endorsements"];
  i = 0;
  popovers = [];
  popoverTexts = [];
  for (shape in shapes) {
    if (i < 4 ) {
      // do nothing
    } else {
      sx = shapes[i].attrs.x + 50;
      sy = shapes[i].attrs.y + 23;
      r.text(sx, sy, nodeTexts[i - 4] + i);
      shapes[i].node.onclick = function() {
        newRect = r.rect(0, 0, 940, 480).attr({
          fill: "#EEE",
          stroke: "#BBB",
          "stroke-width": 3,
          cursor: "move",
        });
        // set the text manually. this is annoying.
        for (key in this) {
          console.log(key);
          }
        if (this.raphaelid == 4) {
          pText = r.text(100, 40, popupTexts[0]);
        } else if (this.raphaelid == 5) {
          // do nothing, this is a non-clickable node
        } else if (this.raphaelid == 6) {
          pText = r.text(100, 40, popupTexts[2]);
        } else if (this.raphaelid == 7) {
          pText = r.text(100, 40, popupTexts[3]);
        } else if (this.raphaelid == 8) {
          pText = r.text(100, 40, popupTexts[4]);
        } else if (this.raphaelid == 9) {
          pText = r.text(100, 40, popupTexts[5]);
        } else if (this.raphaelid == 10) {
          pText = r.text(100, 40, popupTexts[6]);
        }
        newRect.node.onclick = function() {
          pText.hide();
          newRect.hide();
        }
      }
    }
    i = i + 1;
  }
  for (var i = 0, ii = shapes.length; i < ii; i++) {
    var color = "#BBB";
    shapes[i].attr({
      fill: "#EEE", 
      stroke: color, 
      "fill-opacity": 1, 
      "stroke-width": 3, 
      cursor: "move"
    });
  }
  // add images
  if (window.photo_url != undefined) {
    var personImage = window.photo_url
    r.image(personImage, 370, 89, 202, 202)
  }
  // add connections
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
};
