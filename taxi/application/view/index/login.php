<form name="loginForm" method="post" action="<?= URL; ?>login/login">
<label>Login: </label><input type="text" name="login" >
<label>Password: </label><input type="password" name="password" >
<input type="submit" value="Login">
</form>
<script src="<?php echo URL; ?>scripts/libs/jquery/jquery-2.0.3.min.js"></script>
<script>
$(document).ready(function() {
	$('form').on('submit', function() {				
		$.ajax({
			type: 'post',
			url: '<?= URL; ?>login/login',
			data: $('form').serializeArray(),
			success: function(data) {
				if(data.error) {
					alert('error');				
				}
				if(data.url) {
					window.location = data.url;	
				}
			},
			dataType: 'json'
		});		
		return false;
	});	
});
</script>