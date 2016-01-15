var addAnother = function() {
	$('.picture-pickers').append('<div class="picture-picker"> <input type="file" name="item[images][]"> <button type="button" class="button-remove-picker">X</button> </div>');
};

var removePicker = function(e) {
	var parent = e.target.parentElement;
	parent.remove();
};

var disableInterestLevelButton = function(buttonContainer) {
	buttonContainer = $(buttonContainer);
	var initialInterest = buttonContainer.data('initialInterest');
	if (initialInterest === 'interested'){
		buttonContainer.children('.interested-button').prop('disabled', true);
	} else if (initialInterest === 'not interested') {
		buttonContainer.children('.not-interested-button').prop('disabled', true);
	} else {
		buttonContainer.children('.neutral-button').prop('disabled', true);
	}
};

var disableInterestLevelButtons = function(){
	var buttonContainers = $('.interest-level-buttons');
	for (var i = 0; i < buttonContainers.length; i++){
		disableInterestLevelButton(buttonContainers[i]);
	}
};

var swapDisabledButtons = function(currentlyDisabled, toBeDisabled, newRanking) {
	currentlyDisabled.prop('disabled', false);
	toBeDisabled.prop('disabled', true);
}

var updateInterestLevel = function(e) {
	var buttonContainer = $(e.delegateTarget);
	var disabledButton = buttonContainer.children('button:disabled');
	var clickedButton = $(e.target);
	var newInterestLevel = clickedButton.data('level');
	var itemID = buttonContainer.data('item-id');
	$.ajax({
		url: '/items/' + itemID + '/rank',
		data: {ranking: newInterestLevel},
		dataType: 'json',
		method: 'PUT',
		success: swapDisabledButtons.bind(undefined, disabledButton, clickedButton)
	});
};

var setupInterestLevelButtons = function(){
	disableInterestLevelButtons();
	$('.interest-level-buttons').on('click', 'button.interest-level-button', updateInterestLevel);
}


