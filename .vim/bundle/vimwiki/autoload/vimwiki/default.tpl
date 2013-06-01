<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en-us">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="author" content="h2ero" />
    <title>%title% | h2ero's wiki</title>
	<meta name="keywords" content="%title%" />
    <link rel="shortcut icon" href="/favicon.ico">
    <link href="/feed/" rel="alternate" title="h2ero" type="application/atom+xml" />
    <link rel="stylesheet" href="http://blog.h2ero.cn/media/css/style.css">
	<link type="text/css" rel="stylesheet" href="http://blog.h2ero.cn/media/js/s/styles/shCoreEclipse.css"/>
	<script type="text/javascript" src="http://blog.h2ero.cn/media/js/s/scripts/shCore.js"></script>
	<script type="text/javascript" src="http://blog.h2ero.cn/media/js/s/scripts/shAutoloader.js"></script>
    <script type="text/javascript" src="http://blog.h2ero.cn/media/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
    window.onload=function(){
            console.log($("pre"));
            function path()
            {
              var args = arguments,
                  result = []
                  ;
                   
              for(var i = 0; i < args.length; i++)
                  result.push(args[i].replace('@', 'http://blog.h2ero.cn/media/js/s/scripts/'));
                   
              return result
            };
             
            SyntaxHighlighter.autoloader.apply(null, path(
              'applescript            @shBrushAppleScript.js',
              'actionscript3 as3      @shBrushAS3.js',
              'bash shell sh          @shBrushBash.js',
              'coldfusion cf          @shBrushColdFusion.js',
              'cpp c                  @shBrushCpp.js',
              'c# c-sharp csharp      @shBrushCSharp.js',
              'css                    @shBrushCss.js',
              'delphi pascal          @shBrushDelphi.js',
              'diff patch pas         @shBrushDiff.js',
              'erl erlang             @shBrushErlang.js',
              'groovy                 @shBrushGroovy.js',
              'java                   @shBrushJava.js',
              'jfx javafx             @shBrushJavaFX.js',
              'js jscript javascript  @shBrushJScript.js',
              'perl pl                @shBrushPerl.js',
              'php                    @shBrushPhp.js',
              'text plain             @shBrushPlain.js',
              'py python              @shBrushPython.js',
              'ruby rails ror rb      @shBrushRuby.js',
              'sass scss              @shBrushSass.js',
              'scala                  @shBrushScala.js',
              'sql                    @shBrushSql.js',
              'vb vbnet               @shBrushVb.js',
              'xml xhtml xslt html    @shBrushXml.js'
            ));
            SyntaxHighlighter.all();
            };
    </script>
  </head>
  <body>
    <div id="container">
      <div id="main" role="main">
        <header>
        <h1>%title%</h1>
        </header>
        <nav>
        <span><a title="home page" class="" href="/">Home</a></span>
        <span><a title="about" class="" href="/about/">About</a></span>
        <span><a title="guestbook" class="" href="/guestbook/">Guestbook</a></span>
        <span><a title="categories" class="" href="/categories/">Categories</a></span>
        <span><a title="tags" class="" href="/tags/">Tags</a></span>
        <span><a title="links" class="" href="/links/">Links</a></span>
        <span><a title="subscribe by RSS" class="" href="/feed/">Subscribe</a></span>
        </nav>
        <article class="content">
            %content%
            <script type="text/javascript" src="http://blog.h2ero.cn/media/js/main.js"></script>
        </article>
</body>
</html>
