<?php

function copysite_admin_notices() {
	global $wpdb;
	$current_screen = get_current_screen();
	if( $current_screen->id != 'tools' )  { return; }
	?>
	<div class="notice notice-info is-dismissible">

		<?php
		if( ! empty( $_REQUEST['copysite'] ) ) {
			$copysite = preg_replace( '/[^a-z0-9]/', '', $_REQUEST['copysite'] );
			$command = sprintf( "sudo /root/copysite.sh %s %s", $wpdb->dbname, $copysite );
			?>
			<p><pre>Executing command <?php echo $command . "\n"; passthru( $command ); ?></pre></p>
			<p><strong>All Done!</strong> Don't forget to add this new subdomain into GoDaddy as a CNAME record.</p>
		<?php } ?>

		<form method="GET" action="">
			<fieldset>
				<legend>Copy this site to a new site</legend>
				<p>
					<input type="text" name="copysite" />
					<input type="submit" class="button-secondary" value="Copy Site" />
				</p>
			<fieldset>
		</form>

	</div>
	<?php
}

add_action( 'admin_notices', 'copysite_admin_notices' );
