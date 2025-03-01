var nc_resource = GetParentResourceName();
var nc_config = {};
var nc_data = {};
var nc_jobs = {};

window.addEventListener("message", function(event) {
    let data = event.data;

    if ( data.type == 'show' ) {
        $("#nc-container").show();
        nc_config = data.config;
        nc_data = data.data;
        nc_jobs = data.jobs;
        nc_setup_pausemenu();
    } 

    if ( data.type == 'hide' ) {
        $("#nc-container").hide();
    };
});

function nc_setup_pausemenu() {
    var translation = nc_config.nc_translation;
    var gender = translation.male;
    $('#nc-jobs').html('');
    $("#nc-back").html(translation.back);
    $("#nc-disconnect").html(translation.disconnect);
    $("#nc-rules-txt").html(translation.rulestitle);
    $("#nc-rules-rules").html(translation.rules);
    $("#nc-discord-txt").html(translation.discord);
    $('#nc-trans-maps').html(translation.maps);
    $("#nc-trans-tmaps").html(translation.mapstxt);
    $("#nc-trans-settings").html(translation.settings);
    $("#nc-trans-tsettings").html(translation.settingstxt);
    if (nc_data.nc_gender == 1) {
      gender = translation.female;
    }
    if (nc_data.nc_gender == 'm') {
      gender = translation.male;
    }
    if (nc_data.nc_gender == 'f') {
      gender = translation.female;
    }
    var charinfo = "\n    <div class=\"nc-infos-title\">1. <span class=\"nc-clr\">Character Information.</span></div>\n    <div class=\"nc-infos-infos\">\n        <div class=\"nc-infos-box\">\n            <div class=\"nc-box-ele\"></div>\n            <div class=\"nc-box-img\" style=\"background-image: url('./nc-assets/nc-icon-name.svg');\"></div>\n            <div class=\"nc-box-infos\">" + translation.fname + ": <span class=\"nc-clr\">" + nc_data.nc_firstName + "</span></div>\n        </div>\n        <div class=\"nc-infos-box\">\n            <div class=\"nc-box-ele\"></div>\n            <div class=\"nc-box-img\" style=\"background-image: url('./nc-assets/nc-icon-name.svg');\"></div>\n            <div class=\"nc-box-infos\">" + translation.lname + ': <span class="nc-clr">' + nc_data.nc_lastName + "</span></div>\n        </div>\n        <div class=\"nc-infos-box\">\n            <div class=\"nc-box-img\" style=\"background-image: url('./nc-assets/nc-icon-gender.svg');\"></div>\n            <div class=\"nc-box-infos\">" + translation.gender + ": <span class=\"nc-clr-sec\">" + gender + "</span></div>\n        </div>\n        <div class=\"nc-infos-box\">\n            <div class=\"nc-box-img\" style=\"background-image: url('./nc-assets/nc-icon-dob.svg');\"></div>\n            <div class=\"nc-box-infos\">" + translation.dob + ': <span class="nc-clr-sec">' + nc_data.nc_birthdate + "</span></div>\n        </div>\n        <div class=\"nc-infos-box\" style=\"width: 100%;\">\n            <div class=\"nc-box-ele\"></div>\n            <div class=\"nc-box-img\" style=\"background-image: url('./nc-assets/nc-icon-job.svg');\"></div>\n            <div class=\"nc-box-infos\">" + translation.job + ": <span class=\"nc-clr\">" + nc_data.nc_job + "</span> - <span class=\"nc-clr\">" + nc_data.nc_grade + "</span></div>\n        </div>\n        <div class=\"nc-infos-box\">\n            <div class=\"nc-box-img\" style=\"background-image: url('./nc-assets/nc-icon-cash.svg');\"></div>\n            <div class=\"nc-box-infos\">" + translation.cash + ": <span class=\"nc-clr\">" + nc_data.nc_cash + "</span> " + translation.currency + "</div>\n        </div>\n        <div class=\"nc-infos-box\">\n            <div class=\"nc-box-img\" style=\"background-image: url('./nc-assets/nc-icon-bank.svg');\"></div>\n            <div class=\"nc-box-infos\">" + translation.bank + ": <span class=\"nc-clr\">" + nc_data.nc_bank + "</span> " + translation.currency + "</div>\n        </div>\n    </div>\n    <div class=\"nc-triple\" style=\"right: 1.563vw;\"><div class=\"nc-triple-ele\"></div><div class=\"nc-triple-ele\"></div><div class=\"nc-triple-ele\"></div></div>\n    <div class=\"nc-line\" style=\"top: 1.563vw;\"></div>\n    ";
    $("#nc-multi-infos").html(charinfo);
    $.each(nc_jobs, function (_, job) {
      var jobdata = "<div class=\"nc-job\" style=\"border-color: " + job.color + ";\"><span style=\"color: " + job.color + ";\">" + job.name + ":&nbsp</span>" + job.count + ' ' + job.suivname + "</div>";
      $('#nc-jobs').append(jobdata);
    });
  }

  $('#nc-maps').click(function () {
    $.post("https://" + nc_resource + "/show-maps");
  });
  $("#nc-settings-main").click(function () {
    $.post("https://" + nc_resource + "/show-settings");
  });
  $("#nc-back").click(function () {
    $.post("https://" + nc_resource + "/hide");
  });
  $("#nc-disconnect").click(function () {
    $.post("https://" + nc_resource + "/disconnect");
  });
  $("#nc-discord").click(function () {
    window.invokeNative("openUrl", nc_config.discord);
  });

  window.addEventListener("keydown", (event) => {
    if ( event.keyCode == 27 || event.keyCode == 8 ) {
      $.post("https://" + nc_resource + "/hide");
    }
  })