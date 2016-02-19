<?php  
class ControllerNewsletterNewsletter extends Controller {
	public function index() {
		// set title of the page
		$this->document->setTitle("Nyhetsbrev saltvatten");

		// define children templates
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
		  'text'      => $this->language->get('text_home'),
		  'href'      => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
		  'text'      => "Nyhetsbrev saltvatten",
		  'href'      => $this->url->link('newsletter/newsletter')
		);   

		// set data to the variable
		$data['newsletter_text'] = "Prenumerar på nyhetsbrev salt";

		// call the "View" to render the output
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/newsletter/newsletter.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/newsletter/newsletter.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/newsletter/newsletter.tpl', $data));
		}
	}
}
?>
