(function( $ ){
	$.fn.cm = function(id) {
		if (!id) {
			if (this.attr('id')) {
				id = this.attr('id');
			}
		}
		
		var that = function() { 
			return thatRet;
		};
		
		
		
		var thatRet = that;
		
		that.selectedTabIndex = -1;
		
		var tabNames = [];
		
		that.goToBackstage = function() {
			ribObj.addClass('backstage');
		}
			
		that.returnFromBackstage = function() {
			ribObj.removeClass('backstage');
		}	
		var ribObj = null;
		
		that.init = function(id) {
			if (!id) {
				id = 'cm';
			}
		
			ribObj = $('#'+id);
			ribObj.find('.cm-window-title').after('<div id="cm-tab-header-strip"></div>');
			
			ribObj.find('.cm-button').each(function(index) {
				var title = $(this).find('.button-title');
				title.detach();
				$(this).append(title);
				
				var el = $(this);
				
				this.enable = function() {
					el.removeClass('disabled');
				}
				this.disable = function() {
					el.addClass('disabled');
				}
				this.isEnabled = function() {
					return !el.hasClass('disabled');
				}
								
				if ($(this).find('.cm-hot').length==0) {
					$(this).find('.cm-normal').addClass('cm-hot');
				}			
				if ($(this).find('.cm-disabled').length==0) {
					$(this).find('.cm-normal').addClass('cm-disabled');
					$(this).find('.cm-normal').addClass('cm-implicit-disabled');
				}
				
				$(this).tooltip({
					bodyHandler: function () {
						if (!$(this).isEnabled()) { 
							$('#tooltip').css('visibility', 'hidden');
							return '';
						}
						
						var tor = '';

						if (jQuery(this).children('.button-help').size() > 0)
							tor = (jQuery(this).children('.button-help').html());
						else
							tor = '';

						if (tor == '') {
							$('#tooltip').css('visibility', 'hidden');
							return '';
						}

						$('#tooltip').css('visibility', 'visible');

						return tor;
					},
					left: 0,
					extraClass: 'cm-tooltip'
				});
			});
			
			ribObj.find('.cm-section').each(function(index) {
				$(this).after('<div class="cm-section-sep"></div>');
			});

			ribObj.find('div').attr('unselectable', 'on');
			ribObj.find('span').attr('unselectable', 'on');
			ribObj.attr('unselectable', 'on');

		}
		
	
	
		that.init(id);
	
		$.fn.cm = that;
		

	};

})( jQuery );