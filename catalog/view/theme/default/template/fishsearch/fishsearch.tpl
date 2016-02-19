<?php
global $request;

$blacklist = array("'", "--", "@");
$searchfor = str_replace($blacklist, "", $searchfor);
$list = str_replace($blacklist, "", $list);
$orderby = str_replace($blacklist, "", $orderby);
$sortby = str_replace($blacklist, "", $sortby);

if ($sortby == "") {
	$sortby	= "ASC";
}
?>

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
      <h1>Sök fisk i Aquawarehouse beställningslistor</h1>
	  <h3><? echo $infotext; ?></h3><br/>
      <!--   -->
	  <script type="text/javascript">
			
			function showhide() {
				$("#forklaring").toggle();
			}
	  </script>
	 
      <div class="row">

	<div class="col-sm-4">
		<div id="search" class="input-group">
		  <input type="text" name="searchfor" value="<? echo $searchfor; ?>" placeholder="Sök" class="form-control input-lg" />
		  <span class="input-group-btn">
			<button type="button" name="fishsearchbutton" id="fishsearchbutton" class="btn btn-default btn-lg"><i class="fa fa-search"></i></button>
		  </span>
		</div>
	</div>

		  <div class="col-sm-3">
		  		<select name="list" id="list" class="form-control">
					<option value="aktuella" <? IF ($list == 'aktuella') { echo 'selected'; } ?>>Alla aktuella</option>
					<option value="arkiverade" <? IF ($list == 'arkiverade') { echo 'selected'; } ?>>Arkiverade</option>
				</select>
		</div>

		<div class="col-sm-3">
			<a href="index.php?route=fishsearch/fishsearch&list=aktuella&searchfor=">Visa alla aktuella</a> <br/> 
			<a href="index.php?route=fishsearch/fishsearch&list=arkiverade&searchfor=">Visa alla arkiverade</a>
		</div>

		<div class="col-sm-12">
			<a href="javascript:showhide();" style="font-size: 13px;">Sökhjälp &raquo;</a>
			<div style="display:none;" id="forklaring">
				<h4>Sök efter</h4>
				<p>Här kan du söka efter fiskar i våra beställningslistor. <br />Du kan söka på antingen hela eller delar av det <em>Latinska namnet</em> eller det <em>Svenska namnet</em>.</p>
				<h4>Välj lista</h4>
				<p>Du kan välja om du vill söka i:<br />
				<em>De aktuella listorna</em>. Dessa listor är de som gäller nu och vilka vi kan ta hem fisk från.<br />
				<em>De arkiverade listorna</em>. I dessa listor kan du hitta fisk som vi tidigare haft i våra listor, men som nu inte längre är aktuella. Här kan du få en prisbild på fiskar som inte just nu är möjliga att få tag på, men som kan dyka upp i framtida aktuella listor.<br />
				</p>
			</div>
			<br/><br/>
		</div>
			
			
      </div>
	      <div class="row">
			<div class="col-sm-12">
				<table width="100%" class="table table-striped" cellspacing="0" cellpadding="0">
					<tr>
						<th><a href="index.php?route=fishsearch/fishsearch&list=<?php echo $list; ?>&searchfor=<?php echo $searchfor; ?>&orderby=lista&sortby=<?php echo $sortby; ?>">Lista</a></th>
						<th><a href="index.php?route=fishsearch/fishsearch&list=<?php echo $list; ?>&searchfor=<?php echo $searchfor; ?>&orderby=datum&sortby=<?php echo $sortby; ?>">Datum</a></th>
						<th><a href="index.php?route=fishsearch/fishsearch&list=<?php echo $list; ?>&searchfor=<?php echo $searchfor; ?>&orderby=svnamn&sortby=<?php echo $sortby; ?>">Svenskt namn</a></th>
						<th><a href="index.php?route=fishsearch/fishsearch&list=<?php echo $list; ?>&searchfor=<?php echo $searchfor; ?>&orderby=latnamn&sortby=<?php echo $sortby; ?>">Latinskt namn</a></th>
						<th><a href="index.php?route=fishsearch/fishsearch&list=<?php echo $list; ?>&searchfor=<?php echo $searchfor; ?>&orderby=pris&sortby=<?php echo $sortby; ?>">Pris</a></th>
						<th><a href="index.php?route=fishsearch/fishsearch&list=<?php echo $list; ?>&searchfor=<?php echo $searchfor; ?>&orderby=kommentar&sortby=<?php echo $sortby; ?>">Kommentar</a></th>
					</tr>

				<?php foreach ($fishes as $fish) { 
					$lnamn = str_replace('"', "", $fish['lnamn']);
					?>
				
					<tr>
						<td class='fishrow'><?php echo $fish['namn']; ?></td>
						<td class='fishrow'><?php echo $fish['createdate']; ?></td>
						<td class='fishrow'><?php echo $fish['snamn']; ?></td>
						<td class='fishrow'><a href="https://www.google.se/search?q=<?php echo $lnamn; ?>&source=lnms&tbm=isch&sa=X" target=_new><?php echo $fish['lnamn']; ?></a></td>
						<td class='fishrow'><?php echo $fish['pris']; ?>&nbsp;kr</td>
						<td class='fishrow'><?php echo $fish['kommentar']; ?>&nbsp;</td>
					</tr>
				
				<?php } ?>
				</table>
			</div>
      </div>

	  <!--   -->
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/javascript"><!--
$('#fishsearchbutton').bind('click', function() {
	url = 'index.php?route=fishsearch/fishsearch';

	var search = $('#content input[name=\'searchfor\']').prop('value');

	if (search) {
		url += '&searchfor=' + encodeURIComponent(search);
	}

	var list = $('#content select[name=\'list\']').prop('value');

	if (list) {
		url += '&list=' + encodeURIComponent(list);
	}

	// var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');

	// if (sub_category) {
		// url += '&sub_category=true';
	// }

	// var filter_description = $('#content input[name=\'description\']:checked').prop('value');

	// if (filter_description) {
		// url += '&description=true';
	// }

	location = url;
});

$('#content input[name=\'searchfor\']').bind('keydown', function(e) {
	if (e.keyCode == 13) {
		$('#fishsearchbutton').trigger('click');
	}
});

--></script>
<?php echo $footer; ?> 

