package com.scfashion.sale.plugins;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.net.Uri;
import android.util.Log;

import cn.jpush.android.api.JPushInterface;

import com.scfashion.sale.ScfashionApp;

public class CommonPlugin extends CordovaPlugin {
	private static final String METHOD = "method";
	private static final String PARAMETER = "parameter";

	private CallbackContext callbackContext;

	public CommonPlugin() {
	}

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		this.callbackContext = callbackContext;

		try {
			if (action.equals("setUserInfo")) {
				setUserInfo(args);
			} else if (action.equals("getUserInfo")) {
				getUserInfo();
			} else if (action.equals("getVersionAndRegistrationID")) {
				getVersionAndRegistrationID();
			} else if (action.equals("exitApp")) {
				exitApp();
			} else if (action.equals("log")) {
				log(args);
			} else if (action.equals("clearUserInfo")) {
				clearUserInfo();
			} else if (action.equals("openNewPage")) {
				openNewPage(args);
			} else {
				return false;
			}
		} catch (Exception ex) {
			callbackContext.error("Error:" + ex.getMessage());
		}
		return true;
	}

	private void log(JSONArray args) throws JSONException {
		JSONObject obj = args.optJSONObject(0);
		Log.d("HTML", obj.getString("info"));
		JSONObject result = new JSONObject();
		result.put("result", "ok");
		callbackContext.success(result);
	}

	private void setUserInfo(JSONArray args) throws JSONException {
		JSONObject obj = args.optJSONObject(0);
		ScfashionApp.getSettings().PHONE.set(obj.getString("phone"));
		ScfashionApp.getSettings().GUID.set(obj.getString("guid"));
		JSONObject result = new JSONObject();
		result.put("result", "ok");
		callbackContext.success(result);
	}

	private void getUserInfo() throws JSONException, NameNotFoundException {
		PackageManager manager = ScfashionApp.getApp().getPackageManager();
		PackageInfo info = manager.getPackageInfo(ScfashionApp.getApp().getPackageName(), 0);
		JSONObject obj = new JSONObject();
		obj.put("guid", ScfashionApp.getSettings().GUID.get());
		obj.put("phonenum", ScfashionApp.getSettings().PHONE.get());
		obj.put("registrationID", JPushInterface.getRegistrationID(ScfashionApp.getApp()));
		obj.put("appCurVersion", info.versionName);
		callbackContext.success(obj);
	}

	/**
	 * 获取版本号
	 * 
	 * @return 当前应用的版本号
	 * @throws NameNotFoundException
	 *             { Command: "902", GUID: "12345678", EncryptKey:
	 *             "",REGISTRATION_ID:”xxxxxxxxxx”, Version:”1.0.0.0”}
	 * @throws JSONException
	 */
	private void getVersionAndRegistrationID() throws NameNotFoundException, JSONException {
		JSONObject result = new JSONObject();
		PackageManager manager = ScfashionApp.getApp().getPackageManager();
		PackageInfo info = manager.getPackageInfo(ScfashionApp.getApp().getPackageName(), 0);
		result.put("Command", "902");
		result.put("GUID", ScfashionApp.getSettings().GUID.get());
		result.put("REGISTRATION_ID", JPushInterface.getRegistrationID(ScfashionApp.getApp()));
		result.put("Version", info.versionName);
		result.put("EncryptKey", "");
		result.put("Model", "Android");
		callbackContext.success(result);
	}

	private void exitApp() {
		System.exit(0);
	}

	private void clearUserInfo() throws JSONException {
		ScfashionApp.getSettings().PHONE.set("");
		ScfashionApp.getSettings().GUID.set("");
		JSONObject result = new JSONObject();
		result.put("result", "ok");
		callbackContext.success(result);
	}

	private void openNewPage(JSONArray args) throws JSONException {
		JSONObject obj = args.optJSONObject(0);
		String sUrl = obj.getString("page");
		Intent intent = new Intent();
		intent.setData(Uri.parse(sUrl));
		intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
		intent.setAction(Intent.ACTION_VIEW);
		ScfashionApp.getApp().startActivity(intent);
	}
}
