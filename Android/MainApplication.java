package com.dianping.ba.HelloWorld;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import android.app.Application;
import android.content.Context;
import android.telephony.TelephonyManager;

public class MainApplication extends Application {
	private static MainApplication instance;
	private static String deviceId;

	public static MainApplication getInstance() {
		return instance;
	}

	public static String getToken() {
		String packageName = instance.getPackageName();
		return md5(packageName + deviceId);
	}

	private static String md5(String string) {
		byte[] hash;

		try {
			hash = MessageDigest.getInstance("MD5").digest(
					string.getBytes("UTF-8"));
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("Huh, MD5 should be supported?", e);
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("Huh, UTF-8 should be supported?", e);
		}

		StringBuilder hex = new StringBuilder(hash.length * 2);

		for (byte b : hash) {
			int i = (b & 0xFF);
			if (i < 0x10)
				hex.append('0');
			hex.append(Integer.toHexString(i));
		}

		return hex.toString();
	}

	@Override
	public void onCreate() {
		super.onCreate();
		instance = this;

		TelephonyManager telephonyManager = (TelephonyManager) this
				.getSystemService(Context.TELEPHONY_SERVICE);
		deviceId = telephonyManager.getDeviceId();
	}
}
