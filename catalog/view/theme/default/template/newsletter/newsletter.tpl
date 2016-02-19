<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><? echo $newsletter_text; ?></h1>

        <p>Genom att ange din e-postadress här kommer du att bli registrerad som prenumerant på <b>Saltvatten</b> som hanteras av <b>Aquawarehouse</b>. Du kan enkelt avregistrera dig med en länk som finns i varje nyhetsbrev.
        </p>
        <form action="http://gansub.com/s/k5Qhyv4k/" method="post" novalidate>
            
		<div class="row">
			<div class="col-sm-8">
                <div >
                    <label for="id_email">Email:</label>
                    <input id="id_email" maxlength="254" name="email" type="email" class="form-control input-lg" />
                </div>
			</div>
		</div>
            
		<div class="row">
			<div class="col-sm-8">
                <div >
                    <label for="id_first_name">Förnamn:</label>
                    <input id="id_first_name" name="first_name" type="text" class="form-control input-lg" />
                </div>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-8">
                <div >
                    <label for="id_last_name">Efternamn:</label>
                    <input id="id_last_name" name="last_name" type="text" class="form-control input-lg" />
                </div>
			</div>
		</div>
            
                <div  style="display: none" >
                    <label for="id_gan_repeat_email">Do not fill me:</label>
                    <input id="id_gan_repeat_email" maxlength="255" name="gan_repeat_email" type="email" />
                    
                </div>
            
		<div class="row">
			<div class="col-sm-8">
                <br/><input class="form-control" type="submit" value="Prenumerera"/>
            </div>
        </div>

			</form>
		
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?> 

