<?php  
class ControllerFishsearchFishsearch extends Controller {
	
	private $error = array();
   
	public function index() {
		// $this->language->load('information/static'); //Optional. This calls for your language file

		// $this->document->setTitle($this->language->get('heading_title')); //Optional. Set the title of your web page.

		if (isset($this->request->get['searchfor'])) {
			$data['searchfor'] = $this->request->get['searchfor'];
		} else {
			$data['searchfor'] = "";
		}
		
		if (isset($this->request->get['list'])) {
			$data['list'] = $this->request->get['list'];
		} else {
			$data['list'] = "";
		}

		if (isset($this->request->get['orderby'])) {
			$data['orderby'] = $this->request->get['orderby'];
		} else {
			$data['orderby'] = "";
		}

		if (isset($this->request->get['sortby'])) {
			$data['sortby'] = $this->request->get['sortby'];
		} else {
			$data['sortby'] = "";
		}
		
		// hämtar fiskar
		$data['fishes'] = array();
		
		if (isset($this->request->get['searchfor'])) {
			$data['fishes'] = $this->getFishes($data['searchfor'], $data['list'], $data['orderby'], $data['sortby']);
		}

		// ändra sorteringen ifall man klickar på en rubrik igen
		if ($data['sortby'] == 'DESC') {
			$data['sortby'] = 'ASC';
		} else if ($data['sortby'] == 'ASC') {
			$data['sortby'] = 'DESC';
		}

		$this->document->setTitle("Fisksök");

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
		  'text'      => $this->language->get('text_home'),
		  'href'      => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
		  'text'      => "Fisksök",
		  'href'      => $this->url->link('fishsearch/fishsearch')
		);   
		   
		$data['heading_title'] = "Fisksök"; //Get "heading title" from language file.
		
		$fishsetting = $this->getSettings();
		$data['infotext'] = $fishsetting['infotext'];
		
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/fishsearch/fishsearch.tpl')) { //if file exists in your current template folder
		  $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/fishsearch/fishsearch.tpl', $data)); //get it
		} else {
		  $this->response->setOutput($this->load->view('default/template/fishsearch/fishsearch.tpl', $data)); //or get the file from the default folder
		}     
	}
	
	public function getSettings() {
		$sql = "select * from tbl_fishlist_setting where tbl_fishlist_setting_id = 1";
		
		$query = $this->db->query($sql);

		if ($query->num_rows) {
			return array(
				'infotext'       => $query->row['infotext'],
			);
		} else {
			return false;
		}
	}

	public function getFishes($searchfor, $list, $orderby, $sortby) {

		if ($list == 'aktuella') {
			$searchList = " AND L.Status = 1";
		}
		if ($list == 'arkiverade') {
			$searchList = " AND L.Status = 2";
		}
		
		if ($orderby != '') {
			switch ($orderby) {
				case "lista":
					$strSearchOrderby = "L.Namn";
					break; 
				case "datum":
					$strSearchOrderby = "L.CreateDate";
					break; 
				case "svnamn":
					$strSearchOrderby = "I.SNamn";
					break; 
				case "latnamn":
					$strSearchOrderby = "I.LNamn";
					break; 
				case "pris":
					$strSearchOrderby = "I.Pris";
					break; 
				case "kommentar":
					$strSearchOrderby = "I.Kommentar";
					break; 
			}
		} else {
			$strSearchOrderby = "I.SNamn";
		}

		$sql = "SELECT I.*, L.Namn, L.CreateDate FROM tbl_fishlist_items as I, tbl_fishlist as L where L.FishListID = I.FishListID AND (I.LNamn LIKE '%" . $searchfor .  "%' or I.SNamn LIKE '%" . $searchfor .  "%') " . $searchList . " order by " . $strSearchOrderby . " " . $sortby ."";
// echo $sql;

		$fish_data = array();

		$query = $this->db->query($sql);

		foreach ($query->rows as $result) {
			$fish_data[] = array(
				'lnamn'				=> $result['LNamn'],
				'snamn'				=> $result['SNamn'],
				'namn'				=> $result['Namn'],
				'pris'				=> $result['Pris'],
				'createdate'		=> $result['CreateDate'],
				'kommentar'			=> $result['Kommentar'],
				'fishlistitemid'	=> $result['FishListItemID'],
			);
		}

		return $fish_data;
	}		
}
?>
