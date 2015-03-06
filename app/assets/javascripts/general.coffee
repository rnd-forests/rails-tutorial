jQuery ->

    # General notifications
    $('div.alert-success').delay(3000).slideUp();
    $('div.alert-info').delay(3000).slideUp();
    $('[data-toggle="tooltip"]').tooltip();

    # Search form
    search_form = $('#search-form')
    search_box = $('#keyword')
    search_alert = $('#search-alert')

    search_box
    .on "input", ->
        input = $.trim($(this).val())
        if !input || input.length == 0
            search_alert.removeClass('hidden')
            return false
        else
            search_alert.addClass('hidden')

    search_form
    .on "submit", ->
        input = $.trim(search_box.val())
        if !input || input.length == 0
            search_alert.removeClass('hidden')
            return false