/**
 * 
 */
$( "#resendOTP" ).click(function() {	
	$("#otp-form").attr('action', '../VerificationServlet?actionType=resend-otp');
	$("#otp-form").submit();
});