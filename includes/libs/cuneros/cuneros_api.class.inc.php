<?php
/**
 * cuneros_api.class.inc.php
 *
 * Cuneros API Connection class
 *
 * @category   API Connection
 * @package    Cuneros.Api
 * @author     Bastian Lüttig / bastie dot space
 * @copyright  2020 Cuneros.de
 * @license    http://www.gnu.org/licenses/gpl.html GPLv3
 * @version    1.2.2
 * @link       https://www.cuneros.de
 *
 * Changelog
 * 1.2: added send_project method for new cuneros api call
 */
class Access {
    protected $otp = false;
    protected $api_key = '';
    protected $project_id = 1;
    protected $server = 'https://www.cuneros.de/api/';
    protected $user = "";
    protected $amount = 0;
    protected $response = false;
    protected $error_id = 0;
    protected $error_string = "";
    protected $server_ip = "";
    /**
     * Constructor of Access class
     *
     * Will create an instance of the api access class with user and otp as well as api key and project id
     *
     * @param string $otp the users otp, generated from the individual otp link (might be optional)
     * @param string $user the username from cuneros.de
     * @param string $api_key the secret api key from the project settings page
     * @param int $project_id the project id from the project overview page
     *
     * @return Access
     */
    public function __construct($otp, $user, $api_key, $project_id) {
        $this->otp        = $otp;
        $this->user       = trim($user);
        $this->api_key    = $api_key;
        $this->project_id = $project_id;
    }
    /**
     * Information about the user (otp needed)
     *
     * @return stdClass: 
     * {"transaction_data": {
     *    "id": User Id
     *    "registration_date": ISO format registration date
     *    "verified": true/false if user is verified
     *  }
     *  "error_code": error code as per list on cuneros
     *  "api_data": {
     *    "requests_left": api requests left today
     *    "safe_balance": api account safe balance
     *    "account_balance": api account balance
     *  }
     * "ip": detected ip of your server
     * }
     */
    public function info() {
        return $this->request($this->user, 0, "info", 0, "", "");
    }
    /**
     * Send cuneros to user (otp optional)
     *
     * @param int $amount amount to send
     * @param string $subject Subject to appear in transaction list
     * @param bool|string|int $external_id Site transaction id for better filtering purpose (will be stored on cuneros)
     *
     * @return stdClass: 
     * {"transaction_data": {
     *    "date": ISO format of date
     *    "from": from name
     *    "timestamp": unix timestamp
     *    "amount": cuneros amount
     *    "subject": transaction subject
     *    "transaction": transaction id
     *  }
     *  "error_code": error code as per list on cuneros
     *  "api_data": {
     *    "requests_left": api requests left today
     *    "safe_balance": api account safe balance
     *    "account_balance": api account balance
     *  }
     * "ip": detected ip of your server
     * }
     */
    public function send($amount, $subject, $external_id = False) {
        return $this->request(0, $this->user, "send", $amount, $subject, $external_id);
    }
    /**
     * Get cuneros from user (otp needed)
     *
     * @param int $amount amount to get
     * @param string $subject Subject to appear in transaction list
     * @param bool|string|int $external_id Site transaction id for better filtering purpose (will be stored on cuneros)
     * @return stdClass: 
     * {"transaction_data": {
     *    "date": ISO format of date
     *    "from": from name
     *    "timestamp": unix timestamp
     *    "amount": cuneros amount
     *    "subject": transaction subject
     *    "transaction": transaction id
     *  }
     *  "error_code": error code as per list on cuneros
     *  "api_data": {
     *    "requests_left": api requests left today
     *    "safe_balance": api account safe balance
     *    "account_balance": api account balance
     *  }
     * "ip": detected ip of your server
     * }
     */
    public function get($amount, $subject, $external_id = False) {
        return $this->request($this->user, 0, "get", $amount, $subject, $external_id);
    }
    /**
     * get error number of last api call
     *
     * @return int error_id
     */
    public function get_error_number() {
        return $this->error_id;
    }
    /**
    * get detected server ip
     *
     * @return string server_ip
     */
    public function get_server_ip() {
        return $this->server_ip;
    }

    /**
     * get error message of last api call
     *
     * @return string error_string
     */
    public function get_error_message() {
        return $this->error_string;
    }
    /**
     * get success of last api call
     *
     * @return bool (true if successful
     */
    public function get_status() {
        return (0 == $this->error_id);
    }
    /**
     * check transaction (otp optional)
     *
     * @param bool|string|int $external_id Site transaction id to be checked
     *
     * @return stdClass: 
     * {"transaction_data": {
     *    "user": username 
     *    "direction": send/get
     *    "date": ISO format of date
     *    "from": from name
     *    "timestamp": unix timestamp
     *    "amount": cuneros amount
     *    "subject": transaction subject
     *    "transaction": transaction id
     *  }
     *  "error_code": error code as per list on cuneros
     *  "api_data": {
     *    "requests_left": api requests left today
     *    "safe_balance": api account safe balance
     *    "account_balance": api account balance
     *  }
     * "ip": detected ip of your server
     * }
     */
    public function check_transaction($external_id) {
        return $this->request(0, 0, "check_transaction", 0, '', $external_id);
    }
    /**
     * Send cuneros to API Ssafe (otp optional)
     *
     * @param int $amount amount to be stored
     * @param bool|string|int $external_id Site transaction id for better filtering purpose (will be stored on cuneros)
     *
     * @return stdClass: 
     * {"transaction_data": {
     *    "date": ISO format of date
     *    "from": from name
     *    "to": "safe"
     *    "timestamp": unix timestamp
     *    "amount": cuneros amount
     *    "transaction": transaction id
     *  }
     * "error_code": error code as per list on cuneros
     * "api_data": {
     *    "requests_left": api requests left today
     *    "safe_balance": api account safe balance
     *    "account_balance": api account balance
     * }
     * "ip": detected ip of your server
     * }
     */
    public function send_safe($amount, $external_id) {
        return $this->request(0, 0, "safe", $amount, "", $external_id);
    }
    /**
     * Send cuneros to other project account (no otp given)
     *
     * @param int $target_project target project id
     * @param int $amount amount to send
     * @param string $subject Subject to appear in transaction list
     * @param bool|string|int $external_id Site transaction id for better filtering purpose (will be stored on cuneros)
     * @return stdClass: 
     * {"transaction_data": {
     *    "date": ISO format of date
     *    "from": from name
     *    "timestamp": unix timestamp
     *    "amount": cuneros amount
     *    "subject": transaction subject
     *    "transaction": transaction id
     *  }
     *  "error_code": error code as per list on cuneros
     *  "api_data": {
     *    "requests_left": api requests left today
     *    "safe_balance": api account safe balance
     *    "account_balance": api account balance
     *  }
     * "ip": detected ip of your server
     * }
     */
    public function send_project($target_project, $amount, $subject, $external_id=False) {
        return $this->request(0, $target_project, "send_project", $amount, $subject, $external_id);
    }

    /**
     * Check API Account status (no otp needed)
     *
     * @return stdClass: 
     * {"transaction_data": {
     *   "api_end_time": end of payment term for api account (ISO format)
     *   "api_credit_points": Credit points
     *   "api_package": {
     *      "price": Price in Credit Points
     *      "description": description of api package
     *      "requests_per_day": requests per day in this api package
     *      "name": api package name
     *      "max_balance": maximum allowed account balance
     *   },
     *   "api_time_left": time left in days
     *  }
     * "error_code": error code as per list on cuneros
     * "api_data": {
     *    "requests_left": api requests left today
     *    "safe_balance": api account safe balance
     *    "account_balance": api account balance
     * }
     * "ip": detected ip of your server
     * }
     */
    public function get_api_info() {
        return $this->request(0, 0, "api_info", 0, "", 0);
    }
    /**
     * Fetches all not-active users on cuneros.de
     *
     * @return stdClass: 
     * {"blocked_users": [{
     *   "user_id": user id
     *   "username": user name
     *   "registration_date": registration date in iso format
     *   "reasons": array of times blocked.
     *  }]
     */
    public function get_blocked_users() {
        return $this->server_request($this->server, "blocks/", "");
    }
    /**
     * Checks if user is blocked on cuneros.de
     *
     * @param string $username username to be checked
     *
     * @return stdClass: 
     * {"data": "not blocked" or {
     *   "user_id": user id
     *   "username": user name
     *   "registration_date": registration date in iso format
     *   "reasons": array of times blocked.
     *  }
     */
    public function get_blocked_user($username) {
        $str = "blocks/" . $username . "/";
        return $this->server_request($this->server, $str, "");
    }
    protected function gen_hash($otp, $src, $dst, $api_key, $action, $amount) {
        $str  = sprintf("%s%s%s%s%s%s", $otp, $src, $dst, $api_key, $action, $amount);
        $hash = hash("sha512", $str);
        return $hash;
    }
    protected function build_params($src, $dst, $action, $amount, $subject, $external_id, $random_number) {
        $hash = $this->gen_hash($this->otp, $src, $dst, $this->api_key, $action, $amount);
        return array(
            'hash' => $hash,
            'src' => $src,
            'dst' => $dst,
            //	            'api_key' => $this->api_key, // api key is no longer mandatory, as it is included in the hash.
            'action' => $action,
            'amount' => $amount,
            'subject' => $subject,
            'project' => $this->project_id,
            'otp' => $this->otp,
            'external_id' => $external_id,
            'random' => $random_number
        );
    }
    protected function server_request($server, $action_url, $data) {

        $string = $server . $action_url . "?" . $data;
        $ch     = curl_init();

        
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE); // return response as a string
        curl_setopt($ch, CURLOPT_URL, $string); // the URL
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, TRUE); // verify SSL info
        curl_setopt($ch, CURLOPT_FRESH_CONNECT, TRUE); // make sure, connection is new
        
        // Get JSON
        $result  = curl_exec($ch);
        $content = FALSE;
        // Basic error handling
        if (curl_getinfo($ch, CURLINFO_HTTP_CODE) === 200) {
            $content = json_decode($result, FALSE);
        }
        curl_close($ch);
        return $content;
    }
    protected function request($src, $dst, $action, $amount, $subject, $external_id) {
        $action_url         = 'access/';
        $random_number = mt_rand(1000,9999);
        $dat                = http_build_query($this->build_params($src, $dst, $action, $amount, $subject, $external_id, $random_number));
        $data               = $this->server_request($this->server, $action_url, $dat);
        $this->error_id     = $data->error_code;
        if($data->error_code != 0) {
            $this->error_string = $data->error_message;
        }
        $this->server_ip    = $data->ip;
	if($data == FALSE) {
		$this->error_id = 999998;
		$this->error_string = "Sever not reachable.";
	}
	if($random_number != $data->random_number) {
		$this->error_id = 999999;
		$this->error_string = "Random number does not match! ".$random_number . " ". $data->random_number;
	}
        return $data;
    }
}
