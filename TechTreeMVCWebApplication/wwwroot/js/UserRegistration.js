$(function () {

    $("#UserRegistrationModal").on('hidden.bs.modal', function (e) {
        $("#UserRegistrationModal input[name='CategoryId']").val('0');
    });

    $('.RegisterLink').click(function () {

        $("#UserRegistrationModal input[name='CategoryId']").val($(this).attr('data-categoryId'));

        $("#UserRegistrationModal").modal("show");

    });

    $("#UserRegistrationModal input[name = 'AcceptUserAgreement']").click(onAcceptUserAgreementClick);

    $("#UserRegistrationModal button[name = 'register']").prop("disabled", true);

    function onAcceptUserAgreementClick() {
        if ($(this).is(":checked")) {
            $("#UserRegistrationModal button[name = 'register']").prop("disabled", false);
        }
        else {
            $("#UserRegistrationModal button[name = 'register']").prop("disabled", true);

        }

    }

    $("#UserRegistrationModal input[name = 'Email']").blur(function () {

        var email = $("#UserRegistrationModal input[name = 'Email']").val();

        var url = "UserAuth/UserNameExists?userName=" + email;

        $.ajax({
            type: "GET",
            url: url,
            success: function (data) {
                if (data == true) {

                    PresentClosableBootstrapAlert("#alert_placeholder_register", "warning", "Invalid Email", "This email address has already been registered");

                }
                else {
                    CloseAlert("#alert_placeholder_register");
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                var errorText = "Status: " + xhr.status + " - " + xhr.statusText;

                PresentClosableBootstrapAlert("#alert_placeholder_register", "danger", "Error!", errorText);

                console.error(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);

            }
        });
    });


    var registerUserButton = $("#UserRegistrationModal button[name = 'register']").click(onUserRegisterClick);



    function onUserRegisterClick()
    {
        var url = "UserAuth/RegisterUser";

        var antiForgeryToken = $("#UserRegistrationModal input[name='__RequestVerificationToken']").val();
        var email = $("#UserRegistrationModal input[name='Email']").val();
        var password = $("#UserRegistrationModal input[name='Password']").val();
        var confirmPassword = $("#UserRegistrationModal input[name='ConfirmPassword']").val();
        var firstName = $("#UserRegistrationModal input[name='FirstName']").val();
        var lastName = $("#UserRegistrationModal input[name='LastName']").val();
        var address1 = $("#UserRegistrationModal input[name='Address1']").val();
        var address2 = $("#UserRegistrationModal input[name='Address2']").val();
        var postCode = $("#UserRegistrationModal input[name='PostCode']").val();
        var phoneNumber = $("#UserRegistrationModal input[name='PhoneNumber']").val();
        var categoryId = $("#UserRegistrationModal input[name='CategoryId']").val();

        var user = {
            __RequestVerificationToken: antiForgeryToken,
            Email: email,
            Password: password,
            ConfirmPassword: confirmPassword,
            FirstName: firstName,
            LastName: lastName,
            Address1: address1,
            Address2: address2,
            PostCode: postCode,
            PhoneNumber: phoneNumber,
            AcceptUserAgreement: true,
            CategoryId: categoryId
        };

        $.ajax({
            type: "POST",
            url: url,
            data: user,
            success: function (data) {

                var parsed = $.parseHTML(data);

                var hasErrors = $(parsed).find("input[name='RegistrationInValid']").val() == 'true';

                if (hasErrors) {

                    $("#UserRegistrationModal").html(data);
                    var registerUserButton = $("#UserRegistrationModal button[name = 'register']").click(onUserRegisterClick);
                    $("#UserRegistrationModal input[name = 'AcceptUserAgreement']").click(onAcceptUserAgreementClick);

                    $("#UserRegistrationForm").removeData("validator");
                    $("#UserRegistrationForm").removeData("unobtrusiveValidation");
                    $.validator.unobtrusive.parse("#UserRegistrationForm");
                }
                else {
                    location.href = '/Home/Index';
                }

            },
            error: function (xhr,ajaxOptions,thrownError) {
                var errorText = "Status: " + xhr.status + " - " + xhr.statusText;

                PresentClosableBootstrapAlert("#alert_placeholder_register", "danger", "Error!", errorText);

                console.error(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
            }

        });

    }

});