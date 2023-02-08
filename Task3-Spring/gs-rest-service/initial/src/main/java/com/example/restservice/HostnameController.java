package com.example.restservice;

import java.util.concurrent.atomic.AtomicLong;
import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HostnameController {

	private static final String template = "Hello, %s!";
	private final AtomicLong counter = new AtomicLong();

	@GetMapping("/hostname")
	public Hostname hostname(@RequestParam(value = "name", defaultValue = "World") String name) {
		try {  
			InetAddress id = InetAddress.getLocalHost(); 	  
			return new Hostname(counter.incrementAndGet(), String.format(template, id.getHostName()));
	} catch (UnknownHostException e) { 
		return new Hostname(counter.incrementAndGet(), String.format(template, "UnknownHost"));
		}
	}
}
