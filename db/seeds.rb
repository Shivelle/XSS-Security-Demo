

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


posts = Post.create([
  {
    title: 'Simple Text',
    description: 'Just a simple text without anything else. Time to rethink the usage of html_safe etc. This should always be your first question: "Do I actually need to allow any tags here?" A simple text output might suffice.',
    code: '',
    body: "This is just a normal first post without any XSS stuff inside. It's sort of what you would expect from your usual text input."
  },
  {
    title: 'Expected Tags',
    description: 'This is what you maybe want your user to be able to do, to use some font-related tags, making words bold, italic, underlined.',
    code: '',
    body: "This is a post with some <b><i>awesome</i></b> tags. <br>It's what you would maybe want to <strong>work</strong> in a <u>post</u>."
  },
  {
    title: 'Script Injection',
    description: 'Allowing all tags for the user to be able to make stuff bold or italic also enables script tags to be passed through and them being executed.',
    code: 'But instead you get some unwanted <strong>alerts</strong>. <script>alert(document.cookie)</script>',
    body: "This is a post with a script Tag. It's what you'd want to avoid to happen. But instead you get some unwanted <strong>alerts</strong>. <script>alert(document.cookie)</script>"
  },
  {
    title: 'Evil Image',
    description: 'Maybe you want to add an image to some posts? Great idea! This is how it can go wrong by using onerror while purposely causing that error:',
    code: "<img src=x onerror=alert('XSS!') >",
    body: "<img src=x onerror=alert('XSS!') >"
  },
  {
    title: 'Encoded Script',
    description: 'So you put script tags on a blacklist? This is how this could be worked around quite easily by using an encoded script tag:',
    code: '<a&#32;href&#61;&#91;&#00;&#93;"&#00; onmouseover=prompt&#40;1&#41;&#47;&#47;">Hover PLS!</a',
    body: '<a&#32;href&#61;&#91;&#00;&#93;"&#00; onmouseover=prompt&#40;1&#41;&#47;&#47;">Hover PLS!</a <br> <br> <br>'
  },
  {
    title: 'Fancy SVG',
    description: 'Refresh this page to see how broken SVG tags could ruin your day by using a modified svg tag...',
    code: "<svg/onload=alert('Haha!')",
    body: "Check out this awesome svg image we designed for you to see: <svg/onload=alert('Haha!')"
  },
  {
    title: 'Evil Iframe',
    description: 'Classic example for evil iframes:',
    code: "<iframe SRC=\"javascript:alert('XSS');\" ></iframe>",
    body: "Please enter your billing information in the form below:<br><iframe SRC=\"javascript:alert('XSS');\" ></iframe>"
  },
  {
    title: 'Drag this',
    description: 'This will cause an alert on drag by using the ondragend attribute.',
    code: '<xss draggable="true" ondragend="alert(1)">test</xss>',
    body: 'This is some awesome draggable content! You can drag anything below! Give it a try! <xss draggable="true" ondragend="alert(1)">DRAG ME ROUND, ROUND, BABY, ROUND, ROUND 🎵</xss>'
  },
  {
    title: 'Ajax to the max',
    description: 'This button loads a script we created locally, but could also come from an external source. It will be executed via: onclick="loadPostIndex();. <br> Here we are calling .html() to render a partial via ajax which has .html_safe-flagged content.',
    code: "function loadPostIndex() {
      $.ajax({
        url: 'http://localhost:3000/ajax_index',
        dataType: 'html',
        success: function(data){
        console.log(data);
        if(data){
          $('#index').html(data);
        }
      }});
    }",
    body: '<button onclick="loadPostIndex();">Load Stuff</button>'
  },
  {
    title: 'Malformed Tags',
    description: "This problem occurs when the browser tries to fix malformed tags, resulting in the potential execution of a script or different unexpected behavior. Different browsers have different 'fixing behavior'.",
    code: "<script>alert('fixed it! :)')<div> -> <script>alert('fixed it! :)')</script><div></div>",
    body: "The road to hell is paved with good intentions... <script>alert('fixed it! :)')<div> "
  }

])