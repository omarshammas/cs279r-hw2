namespace :app do

	#populates the database with the buttons
	task :populate => :environment do

		Rake::Task['db:reset'].invoke

		[
			{parent: 'home', abr: 'font-btn', name:'Select Font', img:'font_select.png' },
			{parent: 'home', abr: 'font_size-btn', name:'Select Font Size', img:'font_size_select.png' },
			{parent: 'home', abr: 'bold-btn', name:'Change font style to bold', img:'character_bold_small.png' },
			{parent: 'home', abr: 'italic-btn', name:'Change font style to italic', img:'character_italic_small.png' },
			{parent: 'home', abr: 'underline-btn', name:'Change font style to underline', img: 'character_underline_small.png' },
			{parent: 'home', abr: 'strikethrough-btn', name:'Change font style to strikethrough', img: 'character_strikethrough_small.png' },
			{parent: 'home', abr: 'bullet-btn', name:'Bulleted List', img: 'list_bullets.png' },
			{parent: 'home', abr: 'number_list-btn', name:'Numbered List', img: 'list_numbers.png' },
			{parent: 'home', abr: 'multilevel_list-btn', name:'Multilevel List', img: 'list_multilevel.png' },
			{parent: 'home', abr: 'align_left-btn', name:'Align text left', img: 'paragraph_align_left.png' },
			{parent: 'home', abr: 'align_center-btn', name:'Center Text', img: 'paragraph_align_center.png' },
			{parent: 'home', abr: 'align_right-btn', name:'Align text right', img: 'paragraph_align_right.png' },
			{parent: 'home', abr: 'styles-btn', name:'Change Styles', img: 'styles.png' },

			{parent: 'review', abr: 'spelling-btn', name:'Spelling & Grammer', img: 'spelling.png' },
			{parent: 'review', abr: 'thesaurus-btn', name:'Thesaurus', img: 'thesaurus.png' },
			{parent: 'review', abr: 'translate-btn', name:'Translate', img: 'translate.png' },
			{parent: 'review', abr: 'add-comment-btn', name:'Add a comment about this selection', img: 'review_comment-add.png' },
			{parent: 'review', abr: 'delete-comment-btn', name:'Delete the selected comment', img: 'review_comment-delete.png' },
			{parent: 'review', abr: 'previous-comment-btn', name:'Move to the previous comment', img: 'review_comment-previous.png' },
			{parent: 'review', abr: 'next-comment-btn', name:'Move to the next comment', img: 'review_comment-next.png' },
			{parent: 'review', abr: 'add-change-btn', name:'Accept the current change and move to the next change', img: 'review_track_changes-check.png' },
			{parent: 'review', abr: 'delete-change-btn', name:'Reject the current change and move to the next change', img: 'review_track_changes-delete.png' },
			{parent: 'review', abr: 'previous-change-btn', name:'Move to the previous change so you can accept or reject it', img: 'review_track_changes-previous.png' },
			{parent: 'review', abr: 'next-change-btn', name:'Move to the next change so you can accept or reject it', img: 'review_track_changes-next.png' },

			{parent: 'insert', abr: 'cover_page_btn', name:'Insert a cover page', img: 'cover_page.png' },
			{parent: 'insert', abr: 'blank_page_btn', name:'Insert a blank page', img: 'page-add.png' },
			{parent: 'insert', abr: 'page_break_btn', name:'Insert a page break', img: 'page_break.png' },
			{parent: 'insert', abr: 'table_btn', name:'Insert a table', img: 'table-add.png' },
			{parent: 'insert', abr: 'pic_btn', name:'Insert a picture', img: 'insert_picture.png' },
			{parent: 'insert', abr: 'clip_cart_btn', name:'Insert a clip art', img: 'insert_clipart.png' },
			{parent: 'insert', abr: 'shape_btn', name:'Insert a shape', img: 'insert_shapes.png' },
			{parent: 'insert', abr: 'chart_btn', name:'Insert a chart', img: 'insert_chart.png' },
			{parent: 'insert', abr: 'header_btn', name:'View header', img: 'document_header.png' },
			{parent: 'insert', abr: 'footer_btn', name:'View footer', img: 'document_footer.png' },
			{parent: 'insert', abr: 'page_no_btn', name:'Show page numbers', img: 'page_number.png' },
			{parent: 'insert', abr: 'text_box_btn', name:'Insert text box', img: 'text_box.png' },
			{parent: 'insert', abr: 'quick_parts_btn', name:'Insert quick parts', img: 'quick_parts.png' },
			{parent: 'insert', abr: 'word_art_btn', name:'Insert word art', img: 'wordart.png' },

			{parent: 'layout', abr: 'themes_btn', name:'Select theme for document', img: 'themes.png' },
			{parent: 'layout', abr: 'color_btn', name:'Select color theme for document', img: 'colors.png' },
			{parent: 'layout', abr: 'margins_btn', name:'Select the margin sizes for the entire document or the current selection', img: 'margins.png' },
			{parent: 'layout', abr: 'orientation-btn', name:'Switch the pages between portrait and orientation layouts', img: 'orientation.png' },
			{parent: 'layout', abr: 'columns-btn', name:'Split text into columns', img: 'column_two.png' },
			{parent: 'layout', abr: 'watermark-btn', name:'Insert ghosted text behind the content of the page', img: 'watermark.png' },
			{parent: 'layout', abr: 'page_color_btn', name:'Choose a color for the background of the page', img: 'page_color.png' },
			{parent: 'layout', abr: 'border-btn', name:'Add or change the border around the page', img: 'page_borders.png' },
			{parent: 'layout', abr: 'text_wrapping-btn', name:'Modify the way document texts surround objects', img: 'text_wrapping.png' },
			{parent: 'layout', abr: 'align-btn', name:'Select the alignment for the entire document or selection', img: 'align_left.png' },

			{parent: 'view', abr: 'print_lyt_btn', name:'View the document in print layout mode', img: 'view_print_layout.png' },
			{parent: 'view', abr: 'reading_lyt_btn', name:'View the document in full screen layout mode', img: 'view_full_screen_reading.png' },
			{parent: 'view', abr: 'web_lyt_btn', name:'View the document in web layout mode', img: 'view_web_layout.png' },
			{parent: 'view', abr: 'outline_btn', name:'View the document in outline mode', img: 'view_outline.png' },
			{parent: 'view', abr: 'zoom_btn', name:'Zoom into the document', img: 'view_zoom.png' },
			{parent: 'view', abr: 'hundred_pct-btn', name:'View the document at 100% zoom level', img: 'view_page_100percent.png' },
			{parent: 'view', abr: 'one_page-btn', name:'View the document one page at a time', img: 'view_page_one.png' },
			{parent: 'view', abr: 'two_page-btn', name:'View the document two pages at a time', img: 'view_page_two.png' },
			{parent: 'view', abr: 'page_width-btn', name:'View the document at page width', img: 'view_page_width.png' },
			{parent: 'view', abr: 'macros-btn', name:'Insert a macro into the document', img: 'macros'}

		].each do |b|
			Button.create b
		end
	end
end