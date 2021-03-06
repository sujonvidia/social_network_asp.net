﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Upload_test.aspx.cs" Inherits="Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

	<title>jQuery plugin for FileAPI</title>

	<meta name="keywords" content="jQuery, Plugin, FileAPI, html5, upload, multiupload, dragndrop, chunk, chunked, file, image, crop, resize, rotate, html5, rubaxa"/>
	<meta name="description" content="jQuery.fn.fileapi — the best plugin for jQuery (it is true)"/>

	<link href="//fonts.googleapis.com/css?family=Roboto:300" rel="stylesheet" type="text/css"/>
	<link href="./statics/main.css" rel="stylesheet" type="text/css"/>
	<link href="./jcrop/jquery.Jcrop.min.css" rel="stylesheet" type="text/css"/>

	<script>
		var examples = [];
	</script>
</head>
<body>
   <div>
	
					<div id="multiupload">
						<form class="b-upload b-upload_multi" action="http://rubaxa.org/FileAPI/server/ctrl.php" method="POST" enctype="multipart/form-data">

							<div class="js-files b-upload__files">
								<div class="js-file-tpl b-thumb" data-id="<%=System.Guid.NewGuid()%>" title="">
									<div data-fileapi="file.remove" class="b-thumb__del">✖</div>
									<div class="b-thumb__preview">
										<div class="b-thumb__preview__pic"></div>
									</div>
							
									<div class="b-thumb__progress progress progress-small"><div class="bar"></div></div>
								
								</div>
							</div>

							<hr/>
							<div class="btn btn-success btn-small js-fileapi-wrapper">
								<span>Add</span>
								<input type="file" name="filedata" />
							</div>
							<div class="js-upload btn btn-success btn-small">
								<span>Upload</span>
							</div>
						</form>
					</div>
		
				
				<script>
				    examples.push(function () {
				        $('#multiupload').fileapi({
				            multiple: true,
				            elements: {
				                ctrl: { upload: '.js-upload' },
				                empty: { show: '.b-upload__hint' },
				                emptyQueue: { hide: '.js-upload' },
				                list: '.js-files',
				                file: {
				                    tpl: '.js-file-tpl',
				                    preview: {
				                        el: '.b-thumb__preview',
				                        width: 80,
				                        height: 80
				                    },
				                    upload: { show: '.progress', hide: '.b-thumb__rotate' },
				                    complete: { hide: '.progress' },
				                    progress: '.progress .bar'
				                }
				            }
				        });
				    });
				</script>
		

			


	

	</div>


	<div id="popup" class="popup" style="display: none;">
		<div class="popup__body"><div class="js-img"></div></div>
		<div style="margin: 0 0 5px; text-align: center;">
			<div class="js-upload btn btn_browse btn_browse_small">Upload</div>
		</div>
	</div>

	<script src="//code.jquery.com/jquery-1.8.2.min.js"></script>
	<script>!window.jQuery && document.write('<script src="/js/jquery.dev.js"><' + '/script>');</script>

	<script src="//yandex.st/highlightjs/7.2/highlight.min.js"></script>
	<script src="//yandex.st/jquery/easing/1.3/jquery.easing.min.js"></script>


	<script>
	    var FileAPI = {
	        debug: true
			, media: true
			, staticPath: './FileAPI/'
	    };
	</script>
	<script src="./FileAPI/FileAPI.min.js"></script>
	<script src="./FileAPI/FileAPI.exif.js"></script>
	<script src="./jquery.fileapi.js"></script>
	<script src="./jcrop/jquery.Jcrop.min.js"></script>
	<script src="./statics/jquery.modal.js"></script>


	<script>
	    jQuery(function ($) {
	        var $blind = $('.splash__blind');

	        $('.splash')
				.mouseenter(function () {
				    $('.splash__blind', this)
						.animate({ top: -10 }, 'fast', 'easeInQuad')
						.animate({ top: 0 }, 'slow', 'easeOutBounce')
				    ;
				})
				.click(function () {
				    if (!FileAPI.support.media) {
				        $blind.animate({ top: -$(this).height() }, 'slow', 'easeOutQuart');
				    }

				    FileAPI.Camera.publish($('.splash__cam'), function (err, cam) {
				        if (err) {
				            alert("Unfortunately, your browser does not support webcam.");
				        } else {
				            $('.splash').off();
				            $blind.animate({ top: -$(this).height() }, 'slow', 'easeOutQuart');
				        }
				    });
				})
	        ;


	        $('.example').each(function () {
	            var $example = $(this);

	            $example.find('h2').append('<div class="example__tabs"><a class="active" data-tab="javascript">code</a> <a data-tab="html">html</a></div>');

	            $('<div></div>')
					.append('<div data-code="javascript"><pre><code>' + $.trim(_getCode($example.find('script'))) + '</code></pre></div>')
					.append('<div data-code="html" style="display: none"><pre><code>' + $.trim(_getCode($example.find('.example__left'), true)) + '</code></pre></div>')
					.appendTo($example.find('.example__right'))
					.find('[data-code]').each(function () {
					    /** @namespace hljs -- highlight.js */
					    if (window.hljs && (!$.browser.msie || parseInt($.browser.version, 10) > 7)) {
					        this.className = 'example__code language-' + $.attr(this, 'data-code');
					        hljs.highlightBlock(this);
					    }
					})
	            ;
	        });


	        $('body').on('click', '[data-tab]', function (evt) {
	            evt.preventDefault();

	            var el = evt.currentTarget;
	            var tab = $.attr(el, 'data-tab');
	            var $example = $(el).closest('.example');

	            $example
					.find('[data-tab]')
						.removeClass('active')
						.filter('[data-tab="' + tab + '"]')
							.addClass('active')
							.end()
						.end()
					.find('[data-code]')
						.hide()
						.filter('[data-code="' + tab + '"]').show()
	            ;
	        });


	        function _getCode(node, all) {
	            var code = FileAPI.filter($(node).prop('innerHTML').split('\n'), function (str) { return !!str; });
	            if (!all) {
	                code = code.slice(1, -2);
	            }

	            var tabSize = (code[0].match(/^\t+/) || [''])[0].length;

	            return $('<div/>')
					.text($.map(code, function (line) {
					    return line.substr(tabSize).replace(/\t/g, '   ');
					}).join('\n'))
					.prop('innerHTML')
						.replace(/ disabled=""/g, '')
					
                ;
            }


		    // Init examples
		    FileAPI.each(examples, function (fn) {
		        fn();
		    });
		});
	</script>

	
</body>
</html>
