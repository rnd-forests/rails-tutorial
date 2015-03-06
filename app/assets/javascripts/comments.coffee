jQuery ->
    $(document).ready ->
        $('#new_comment')
            .on "ajax:beforeSend", (evt, xhr, settings) ->
                $(this).find('textarea')
                    .attr('disabled', 'disabled');
            .on "ajax:success", (evt, data, status, xhr) ->
                $(this).find('textarea')
                    .removeAttr('disabled', 'disabled')
                    .val('');

        $(document)
            .on "ajax:beforeSend", ".comment", ->
                $(this).fadeTo('fast', 0.5)
            .on "ajax:success", ".comment", ->
                $(this).hide('fast')
            .on "ajax:error", ".comment", ->
                $(this).fadeTo('fast', 1)