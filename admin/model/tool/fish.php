<?php
class ModelToolFish extends Model {
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

	public function editSettings($data) {
		echo "edit";
		$this->db->query("UPDATE tbl_fishlist_setting SET infotext = '" . $this->db->escape($data['infotext']) . "' WHERE tbl_fishlist_setting_id = 1");
		
		if($data['fishlistid'] > 0) {
			if(isset($data['liststatus'])) {
				$status = $data['liststatus'];
				if ($data['liststatus'] == "") { 
					$status = "2"; 
				}
			}
			else {
				$status = "2"; 
			}
			
			$this->db->query("update tbl_fishlist set Status = " . $status . ", CreateDate = '" . $this->db->escape($data['listdate']) . "',Namn = '" . $this->db->escape($data['listname']) . "' WHERE FishListID = " . $this->db->escape($data['fishlistid']));
		}
	}

	public function getFishLists() {
		$query = $this->db->query("SELECT * FROM tbl_fishlist WHERE Status >= 0 ORDER BY CreateDate DESC");
	
		foreach ($query->rows as $result) {
			if($result['Status'] == 1) {
				$statustext = "aktiv";
			} else if($result['Status'] == 2) {
				$statustext = "inaktiv";
			} else if($result['Status'] == 0) {
				$statustext = "osynlig";
			}
		
			$fishList[] = array(
				'fishlistid'    => $result['FishListID'],
				'createdate'    => $result['CreateDate'],
				'namn'       	=> $result['Namn'],
				'status'       	=> $result['Status'],
				'statustext'   	=> $statustext,
			);
		}
		
		return $fishList;
	}
	
	public function import($data, $filedata) {
		/*	Skapa lista */
		$this->db->query("insert into tbl_fishlist (namn, createdate) values('" . $data['importlistname'] . "','" . $data['importdate'] . "')");
		$fishlistid = $this->db->getLastId();

		// setlocale(LC_ALL, 'swe');
		foreach (explode("\r", $filedata) as $row) {
			list($snamn, $lnamn, $pris) = explode(";", $row);
			
			// $search  = array('', '€', '…');
			// $replace = array('Å', 'Ä', 'Ö');
			// $search  = array('€', '…');
			// $replace = array('Ä', 'Ö');
			// $snamn = strtr($snamn, '€', 'Ä');
			
			// $snamn = iconv("macintosh", "UTF8", $snamn);
			
			$sql = "INSERT INTO tbl_fishlist_items (FishListID,CreateDate,LNamn,SNamn,Pris,Kommentar,Status) values(" 
				. $fishlistid . ", now(), '" . $lnamn . "', '" . $snamn . "', '" . $pris . "', '', 1)"; 
				
			$this->db->query($sql);
			// echo $sql . "<br/>";
		}
		// setlocale(LC_ALL);
	}
}