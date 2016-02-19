<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-infotext" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <button type="submit" form="form-import" data-toggle="tooltip" title="Importera fisklistan" class="btn btn-default"><i class="fa fa-upload"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" form="form-infotext" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-exchange"></i> Generella inställningar</h3>
      </div>
      <form action="<?php echo $edit; ?>" method="post" enctype="multipart/form-data" id="form-infotext" class="form-horizontal">
      <div class="panel-body">
          <div class="form-group">
            <label class="col-sm-1 control-label" for="input-infotext"><?php echo $entry_infotext; ?></label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="infotext" id="input-infotext" value="<?php echo $infotext; ?>" />
            </div>
          </div>
      </div>
		  
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-exchange"></i> Fisklistor</h3>
      </div>
      <div class="panel-body">
		<div class="form-group">
			<div class="col-sm-10">
				<span class="col-sm-3">
					<label class="control-label" for="input-listname">Fisklista: </label>
					<select name="fishlist" id="fishlist" class="col-sm-2 form-control">
						<?php foreach ($fishlists as $fishlist) { ?>
							<option data-name="<?php echo $fishlist['namn']; ?>" data-createdate="<?php echo $fishlist['createdate']; ?>" data-status="<?php echo $fishlist['status']; ?>" value="<?php echo $fishlist['fishlistid']; ?>"><?php echo $fishlist['createdate']; ?> : <?php echo $fishlist['namn']; ?> : <?php echo $fishlist['statustext']; ?></option>
						<?php } ?>
					</select>
				</span>
				<span class="col-sm-2">
					&nbsp;&nbsp;&nbsp;&nbsp;<label class="control-label" for="input-listname">Namn: </label><input type="text" class="form-control" name="listname" id="input-listname" size="40" />
				</span>
				<span class="col-sm-2">
					<label class="control-label" for="input-listdate">Datum: </label><input type="text" class="col-sm-3 form-control" name="listdate" id="input-listdate" size="20" />
				</span>
				<span class="col-sm-1">
					&nbsp;&nbsp;<label class="control-label" for="listaktiv">Aktiv</label><input type="radio" class="form-control" name="liststatus" id="listaktiv" value="1">&nbsp;
				</span>
				<span class="col-sm-1">
					<label class="control-label" for="listinaktiv">Inaktiv</label><input type="radio" class="form-control" name="liststatus" id="listinaktiv" value="2">&nbsp;
				</span>
				<span class="col-sm-1">
					<label class="control-label" for="listosynlig">Osynlig</label><input type="radio" class="form-control" name="liststatus" id="listosynlig" value="0">&nbsp;
				</span>
				<input type="hidden" name="fishlistid" id="input-fishlistid" value="0"/>
			
			</div>
          </div>
        </div>
	  </form>

      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-exchange"></i> Import av fisklista</h3>
      </div>
	  <form action="<?php echo $import; ?>" method="post" enctype="multipart/form-data" id="form-import" class="form-horizontal">
      <div class="panel-body">
          <div class="form-group">
		  <div class="col-sm-12">
				<label class="col-sm-2 control-label" for="input-import">Importera ny fisklista:</label>
				<div class="col-sm-10">
				  <input type="file" name="import" id="input-import" />
				</div>
			</div>
			<div class="col-sm-12">
				<label class="col-sm-2 control-label" for="input-importlistname">Namn på fisklistan:</label>
				<div class="col-sm-7">
				  <input type="text" class="form-control" name="importlistname" id="input-importlistname" />
				</div>
			</div>
			<div class="col-sm-12">
				<label class="col-sm-2 control-label" for="input-importdate">Datum på fisklistan:</label>
				<div class="col-sm-7">
				  <input type="text" class="form-control" name="importdate" id="input-importdate" value="<?php echo $datenow; ?>"/>
				</div>
			</div>
          </div>
      </div>
	  </form>

	  </div>
  </div>
</div>
</div>

<script type="text/javascript"><!--

$("select[name=\'fishlist\']").change(function() {
    var selected = $(this).find('option:selected');

	$("#input-fishlistid").val(selected.val());
	$("#input-listname").val(selected.data('name'));
	$("#input-listdate").val(selected.data('createdate'));
	
	if(selected.data('status') === 1) {
		$("#listaktiv").prop('checked', true);
	} else if(selected.data('status') === 2) {
		$("#listinaktiv").prop('checked', true);
	} else if(selected.data('status') === 0) {
		$("#listosynlig").prop('checked', true);
	}
});

$("select[name=\'fishlist\']").change();
-->
</script>

<?php echo $footer; ?>