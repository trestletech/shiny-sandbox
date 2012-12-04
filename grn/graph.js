<style>

.node {
  stroke: #fff;
  stroke-width: 1.5px;
}

.link {
  stroke: #999;
  stroke-opacity: .6;
}

</style>

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

      //format nodes object
      var nodes = new Array();
      for (var i = 0; i < data.names.length; i++){
        nodes.push({"name": data.names[i]})
      }


      var width = 700;
      var height = 500;
    
      var lin = [{"source":1, "target":2}]            
      var force = d3.layout.force()
        .nodes(nodes)
        .links(lin)
        .charge(-120)
        .linkDistance(30)        
        .size([width, height])
        .start();
      
      //remove the old graph
      var svg = d3.select(el).select("svg");
      svg.remove();
      
      //append a new one
      svg = d3.select(el).append("svg");
      
      svg.attr("width", width)
        .attr("height", height);
    
      var link = svg.selectAll("line.link")
          .data(lin)
        .enter().append("line")
          .attr("class", "link")
          .style("stroke-width", function(d) { return Math.sqrt(d.value); });
    
      var node = svg.selectAll("circle.node")
          .data(nodes)
        .enter().append("circle")
          .attr("class", "node")
          .attr("r", 5)
          //.style("fill", function(d) { return color(d.group); })
          .call(force.drag);
      node.append("title")
        .text(function(d) { return d.name; });
        
        
      force.on("tick", function() {
        link.attr("x1", function(d) { return d.source.x; })
            .attr("y1", function(d) { return d.source.y; })
            .attr("x2", function(d) { return d.target.x; })
            .attr("y2", function(d) { return d.target.y; });
    
        node.attr("cx", function(d) { return d.x; })
            .attr("cy", function(d) { return d.y; });
      });
      
    }
  });
  Shiny.outputBindings.register(networkOutputBinding, 'trestletech.networkbinding');
  
  </script>
