<?php
class ControllerToolFish extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('user/user');
		$this->load->language('tool/fish');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('tool/fish');
		
		$data['tmp'] = "";
		
		$this->start($data);
	}
	
	public function start($data) {

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_select_all'] = $this->language->get('text_select_all');
		$data['text_unselect_all'] = $this->language->get('text_unselect_all');

		$data['entry_infotext'] = $this->language->get('entry_infotext');
		$data['entry_backup'] = $this->language->get('entry_backup');

		$data['button_backup'] = $this->language->get('button_backup');
		$data['button_restore'] = $this->language->get('button_restore');

		if (isset($this->session->data['error'])) {
			$data['error_warning'] = $this->session->data['error'];

			unset($this->session->data['error']);
		} elseif (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		
		$fishsetting = $this->model_tool_fish->getSettings();
		$data['infotext'] = $fishsetting['infotext'];

		$data['fishlists'] = $this->model_tool_fish->getFishLists();
		
		$data['datenow'] = date("Y-m-d");
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('tool/fish', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['edit'] = $this->url->link('tool/fish/edit', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['cancel'] = $this->url->link('tool/fish', 'token=' . $this->session->data['token'], 'SSL');

		$data['import'] = $this->url->link('tool/fish/import', 'token=' . $this->session->data['token'], 'SSL');

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('tool/fish.tpl', $data));
	}
	
	public function edit() {
		$this->load->language('user/user');
		$this->load->language('tool/fish');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('tool/fish');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_tool_fish->editSettings($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_edit_success');
		}

		$data['tmp'] = "";
		$this->start($data);
	}
	
	public function import() {
		$this->load->language('user/user');
		$this->load->language('tool/fish');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('tool/fish');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateFormImport()) {
			if (is_uploaded_file($this->request->files['import']['tmp_name'])) {
				$content = file_get_contents($this->request->files['import']['tmp_name']);
			} else {
				$content = false;
			}

			if ($content) {
				$this->model_tool_fish->import($this->request->post, $content);
				
				$this->session->data['success'] = $this->language->get('text_success');

				// $this->response->redirect($this->url->link('tool/fish', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->error['warning'] = $this->language->get('error_empty');
			}
		}

		$data['tmp'] = "";
		$this->start($data);
	}
	
	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'tool/fish')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	protected function validateFormImport() {
		if (!$this->user->hasPermission('modify', 'tool/fish')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		// TODO importlistname
		
		return !$this->error;
	}

}
