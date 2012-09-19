  <script>
    var percentages = <%= @demographic_pie_percentages %>;
    var p = Raphael("demographics-pie-chart");
    var pie = p.piechart(190, 170, 150, percentages, {legend: percentages});
  </script>
  <div id="demographics-pie-chart" style="width: 900px;">
    <ul id="demographics-legend">
      <% @legend.each do |l| %>
        <li><%= l %></li>
      <% end %>
      </ul>
  </div>
