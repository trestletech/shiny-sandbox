<script src="http://d3js.org/d3.v2.js"></script>
<script type="text/javascript">var networkOutputBinding = new Shiny.OutputBinding();
  $.extend(networkOutputBinding, {
    find: function(scope) {
      return $(scope).find('.shiny-network-output');
    },
    renderValue: function(el, data) {
      function get2DArray(size) {
          size = size > 0 ? size : 0;
          var arr = [];
      
          while(size--) {
              arr.push([]);
          }
      
          return arr;
      }

      //convert data to 2d array
      d2 = get2DArray(data.names.length);
      
      var curRow = 0;
      for (var i = 0; i < data.data.length; i++){
        d2[curRow].push(data.data[i]);
        if (d2[curRow].length == data.names.length){
          curRow++;
        }
      }

      data.data = d2;

      var lin = new Array();
      lin.source = data.names[1];
      lin.target = data.names[2];

      var width = 500;
      var height = 300;

      var force = d3.layout.force()
        .nodes(data.names)
        .links(lin)
        .size([width, height])
        .start();

      
      var svg = d3.select(el).append("svg");
      
      svg.attr("width", width)
        .attr("height", height);
    
      var link = svg.selectAll("line.link")
          .data(lin)
        .enter().append("line")
          .attr("class", "link")
          .style("stroke-width", function(d) { return Math.sqrt(d.value); });
    
      var node = svg.selectAll("circle.node")
          .data(data.names)
        .enter().append("circle")
          .attr("class", "node")
          .attr("r", 5)
          //.style("fill", function(d) { return color(d.group); })
          .call(force.drag);

      
    }
  });
  Shiny.outputBindings.register(networkOutputBinding, 'trestletech.networkbinding');
  
  </script>
