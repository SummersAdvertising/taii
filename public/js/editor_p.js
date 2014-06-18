editor.p = {
	initTab: function(){
		var li = $("<li>");
		li.attr("data-type", "p").attr("id", "tab-p");
		var a = $("<a>").append("段落");
		var icon = $("<img>").attr("src", "/images/paragraph.png");
		a.prepend(icon);

		li.append(a);

		$(".editorList").append(li);
	},
	initPost: function(){
		var editorChild = $("<div>");
		editorChild.attr("id", "post-p");
		editorChild.addClass("editorChild");

		

		var text = $("<textarea>");
		text.addClass("autogrow");
		text.attr("id", "newParagraphContent").attr("placeholder", "").attr("cols", "").attr("rows", "").attr("class","autogrow");
		text.attr("style", "overflow: hidden; word-wrap: break-word; height: 49px;")
		
		var textareaDiv = $("<div>");
		textareaDiv.attr("id","textarea_grower_0");
		textareaDiv.attr("style","position: absolute; z-index: -1000; visibility: hidden; min-height: 20px; font-size: 14px; width: 731px; word-wrap: break-word;");
		
		//table
		var table = $('<table width="100%" border="0" cellspacing="0" cellpadding="0"></table>');
		var link = $("<input>");
		link.attr("type", "text").attr("id", "newParagraphLink").attr("placeholder", "輸入連結網址").attr("class", "text");
		
		tr1 = $('<tr>');
		tr1.append($('<td width="38%" id ="selectionarea">'));
		tr1.append($('<td width="2%">'));
		tr1.append($('<td width="6%">').append("連結："));
		tr1.append($('<td width="54%">').append(link));
		
		table.append(tr1);

		table.append($('<tr>').append($("<td colspan='4'>").append(text).append(textareaDiv)));
		
		$(".editorContent > .form ").append(editorChild.append(table));
		
		/* 插入選單：class, fontcolor, fontsize */
		var selectList = editor.settings.p_selectList;
		for(var item in selectList){
			if(editor.settings[selectList[item]]){
				var type = selectList[item];
				var select = $("<select>");
				select.attr("id", ("new" + capitalize(type)) );

				for(var child in editor.settings[type]){
					var option = $("<option>");
					
					option.append(child);

					if(editor.settings[type][child] == "default"){
						option.attr("selected", "selected");
						option.attr("value", "false");
						select.prepend(option);
					}
					else{
						option.attr("value", editor.settings[type][child].toString());
						select.append(option);
					}
				}
				
				$("#selectionarea").append(select);
				//alert('x');
				//editorChild.append(select); //append select

			}
			if(item == selectList.length-1){
				editorChild.append($("<br>"));
			}
		}
		
	},
	add: function(){
		if(!$("#newParagraphContent").val()){
			editor.alert("請輸入內容", "error");
			return ;
		}
		var paragraph = new Object();
		var paragraphAttrs = ["fontSize", "fontColor", "fontClass", "link", "content"];

		$.each(paragraphAttrs, function(index, value) {
			var attrEle = $("#newParagraph"+capitalize(value));
			if (attrEle.val() && attrEle.val() != "false") {
				switch(value){
					case "fontSize":
						paragraph[value] = attrEle.val() + "px";
					break;
					case "content":
						paragraph[value] = editor.filter(attrEle.val(), editor.HTMLfilter);
					break;
					default:
						paragraph[value] = attrEle.val();
					break;
				}
			}
		});

		editor.p.show(paragraph);
		editor.resetChild();

		editor.save();
	},
	show: function(paragraph){
		var paragraphBox = this.output(paragraph);
		paragraphBox.addClass("paragraphContainer");
		
		this.bindControl(paragraphBox);
	},
	output: function(paragraph){
		var paragraphBox = $("<div class='part'>");
		paragraphBox.attr("data-type", "p");

		paragraph.content = editor.filter(paragraph.content, editor.n2br);

		var p = $("<p>");
		if(paragraph.fontSize){
			p.css("font-size", paragraph.fontSize).attr("data-fontsize", paragraph.fontSize);
		}
		if(paragraph.fontColor){
			p.css("color", paragraph.fontColor).attr("data-fontcolor", paragraph.fontColor);
		}
		if(paragraph.fontClass){
			p.addClass(paragraph.fontClass);
		}

		if(paragraph.link){
		  var a = $("<a>");
		  a.attr("target", "_blank").attr("href", paragraph.link);
		  a.html(paragraph.content);

		  $(p).append(a);
		}
		else{
		  $(p).html(paragraph.content);
		}

		$(paragraphBox).append(p);
		$(editor.settings.articleSection).append(paragraphBox);

		return paragraphBox;
	},
	edit: function(paragraphContainer, controlPanel){

		$('[_height=auto]').height($('[_height=auto]').height()+100);

		controlPanel.hide();
		$(controlPanel).parents(".paragraphContainer").removeClass('part');
		
		$(".controlPanel a[data-control = edit]").each(function(){
			$(this).unbind();
		});

		var editPanel = $("<div>");
		editPanel.addClass("editbox part-edit");
		var editContent = paragraphContainer.children("p:first").hide().html();

		//var reLink = /^\<[a|A]([\S\s]+)href\=\"([\S\s]+)\"\>(.+)\<\/[a|A]\>/;
		//var contentLink = reLink.exec(editContent.toString());

		var contentLink = paragraphContainer.children("p:first").children("a:first");

		if(contentLink.length > 0){
			contentLink.aLink = contentLink.attr("href");
			contentLink.aContent = contentLink.html();

			editContent = contentLink.aContent;
		}

		if(editor.settings.linkedp){
			var link = $("<label>");
			link.append("連結: ");
			var linkContent = $("<input type='text' size='50'>");
			linkContent.attr("placeholder", "段落尚未建立連結。").val(contentLink.aLink? contentLink.aLink:"");
		}

		var textarea = $("<textarea>");
			textarea.addClass("autogrow");
			textarea.val(editor.filter(editContent, editor.br2n, editor.HTMLparser).replace(/&nbsp;/g, ' '));

		var cancel = $("<a>");
		cancel.append("取消");
		cancel.click(function(){
			//edit => add; cancel => minus; complete => minus
			$('[_height=auto]').height($('[_height=auto]').height()-100);

			editPanel.remove();
			controlPanel.removeAttr("style");
			paragraphContainer.children("p:first").show();

			$(".controlPanel a[data-control = edit]").each(function(){
				var type = $(this).parents(".paragraphContainer").data("type");
				editor[type].bindEdit(this);
			});
			
			$(controlPanel).parents(".paragraphContainer").addClass('part');
			
			editor.save();
		});

		var save = $("<a>");
		save.append("完成");
		save.click(function(){
			editContent = editor.filter(textarea.val(), editor.HTMLfilter, editor.n2br);
			if(editContent){
				//edit => add; cancel => minus; complete => minus
				$('[_height=auto]').height($('[_height=auto]').height()-100);
				editPanel.remove();
				controlPanel.removeAttr("style");

				if(linkContent && linkContent.val()){
					var pContent = "<a href="+linkContent.val() + ">" +
									editContent + 
									"</a>";
				}
				else{
					var pContent = editContent;
				}
				paragraphContainer.children("p:first").show().html(pContent);

				editor.save();

				$(".controlPanel a[data-control = edit]").each(function(){
					var type = $(this).parents(".paragraphContainer").data("type");
					editor[type].bindEdit(this);
				});
				
				$(controlPanel).parents(".paragraphContainer").addClass('part');
			}
			else{
				editor.alert("請輸入修改內容", "error");
			}
			
		});

		var editbtnBar = $("<div>");
		editbtnBar.addClass("tool tool-a ").append(save).append(cancel);
		editPanel.append(textarea).append($("<br>")).append(link? link:"").append(linkContent? linkContent:"").append(editbtnBar);
		paragraphContainer.append(editPanel);
	},
	bindControl: function(paragraphBox){
	
	
		var controlPanel = $("<div>");
		controlPanel.addClass("controlPanel tool-b tool");

		var edit = $("<a>");
		edit.attr("data-control", "edit");
		edit.append("編輯").addClass("edit");
		editor.p.bindEdit(edit);

		var del = $("<a>");
		del.attr("data-control", "del").addClass("delete");
		del.append("刪除");
		del.click(function(){
			paragraphBox.remove();
			editor.save();
		});

		controlPanel.append(edit).append(del);
		paragraphBox.prepend(controlPanel);

	},
	bindEdit: function(edit){
		$(edit).bind("click", function(){
			$(".action").hide();
			var controlPanel = $(this).parents(".controlPanel");
			var paragraphContainer = $(this).parents(".paragraphContainer");
			editor.p.edit(paragraphContainer, controlPanel);
		});
	},
	pack: function(paragraphContainer){
		var paragraph = new Object();
		var content = $(paragraphContainer).children("p:first");

		paragraph.type = "p";
        paragraph.fontColor = content.data('fontcolor');
        paragraph.fontSize = content.data('fontsize');
        paragraph.fontClass = content.attr("class");

        var a = $(content).children('a:first');

        if ( a.length > 0 ) {         
          paragraph.link = a.attr('href');          
          paragraph.content = a.html();
        }
        else {
          paragraph.content = content.html();         
        }

        paragraph.content = editor.filter(paragraph.content, editor.br2n);

		return paragraph;
	}
};
function capitalize(str){
	return str.charAt(0).toUpperCase() + str.slice(1);
}