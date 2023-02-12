Array.prototype.filter||(Array.prototype.filter=function(t,e){"use strict";if("Function"!=typeof t&&"function"!=typeof t||!this)throw new TypeError;var r=this.length>>>0,o=new Array(r),n=this,l=0,i=-1;if(void 0===e)for(;++i!==r;)i in this&&t(n[i],i,n)&&(o[l++]=n[i]);else for(;++i!==r;)i in this&&t.call(e,n[i],i,n)&&(o[l++]=n[i]);return o.length=l,o}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var e,r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if("function"!=typeof t)throw new TypeError(t+" is not a function");for(arguments.length>1&&(e=arguments[1]),r=0;r<n;){var l;r in o&&(l=o[r],t.call(e,l,r,o)),r++}}),window.NodeList&&!NodeList.prototype.forEach&&(NodeList.prototype.forEach=Array.prototype.forEach),Array.prototype.indexOf||(Array.prototype.indexOf=function(t,e){var r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if(0===n)return-1;var l=0|e;if(l>=n)return-1;for(r=Math.max(l>=0?l:n-Math.abs(l),0);r<n;){if(r in o&&o[r]===t)return r;r++}return-1}),document.getElementsByClassName||(document.getElementsByClassName=function(t){var e,r,o,n=document,l=[];if(n.querySelectorAll)return n.querySelectorAll("."+t);if(n.evaluate)for(r=".//*[contains(concat(' ', @class, ' '), ' "+t+" ')]",e=n.evaluate(r,n,null,0,null);o=e.iterateNext();)l.push(o);else for(e=n.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+t+"(\\s|$)"),o=0;o<e.length;o++)r.test(e[o].className)&&l.push(e[o]);return l}),document.querySelectorAll||(document.querySelectorAll=function(t){var e,r=document.createElement("style"),o=[];for(document.documentElement.firstChild.appendChild(r),document._qsa=[],r.styleSheet.cssText=t+"{x-qsa:expression(document._qsa && document._qsa.push(this))}",window.scrollBy(0,0),r.parentNode.removeChild(r);document._qsa.length;)(e=document._qsa.shift()).style.removeAttribute("x-qsa"),o.push(e);return document._qsa=null,o}),document.querySelector||(document.querySelector=function(t){var e=document.querySelectorAll(t);return e.length?e[0]:null}),Object.keys||(Object.keys=function(){"use strict";var t=Object.prototype.hasOwnProperty,e=!{toString:null}.propertyIsEnumerable("toString"),r=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],o=r.length;return function(n){if("function"!=typeof n&&("object"!=typeof n||null===n))throw new TypeError("Object.keys called on non-object");var l,i,s=[];for(l in n)t.call(n,l)&&s.push(l);if(e)for(i=0;i<o;i++)t.call(n,r[i])&&s.push(r[i]);return s}}()),"function"!=typeof String.prototype.trim&&(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),String.prototype.replaceAll||(String.prototype.replaceAll=function(t,e){return"[object regexp]"===Object.prototype.toString.call(t).toLowerCase()?this.replace(t,e):this.replace(new RegExp(t,"g"),e)}),window.hasOwnProperty=window.hasOwnProperty||Object.prototype.hasOwnProperty;
if (typeof usi_commons === 'undefined') {
	usi_commons = {
		
		debug: location.href.indexOf("usidebug") != -1 || location.href.indexOf("usi_debug") != -1,
		
		log:function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log(msg.name + ': ' + msg.message);
					} else {
						console.log.apply(console, arguments);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_error: function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg.name + ': ' + msg.message);
					} else {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_success: function(msg) {
			if (usi_commons.debug) {
				try {
					console.log('%c USI Success:', usi_commons.log_styles.success, msg);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		dir:function(obj) {
			if (usi_commons.debug) {
				try {
					console.dir(obj);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_styles: {
			error: 'color: red; font-weight: bold;',
			success: 'color: green; font-weight: bold;'
		},
		domain: "https://app.upsellit.com",
		cdn: "https://www.upsellit.com",
		is_mobile: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()),
		device: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()) ? 'mobile' : 'desktop',
		gup:function(name) {
			try {
				name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
				var regexS = "[\\?&]" + name + "=([^&#\\?]*)";
				var regex = new RegExp(regexS);
				var results = regex.exec(window.location.href);
				if (results == null) return "";
				else return results[1];
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_script:function(source, callback, nocache) {
			try {
				if (source.indexOf("//www.upsellit.com") == 0) source = "https:"+source; //upgrade non-secure requests
				var docHead = document.getElementsByTagName("head")[0];
				if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
				var newScript = document.createElement('script');
				newScript.type = 'text/javascript';
				var usi_appender = "";
				if (!nocache && source.indexOf("/active/") == -1 && source.indexOf("_pixel.jsp") == -1 && source.indexOf("_throttle.jsp") == -1 && source.indexOf("metro") == -1 && source.indexOf("_suppress") == -1 && source.indexOf("product_recommendations.jsp") == -1 && source.indexOf("_pid.jsp") == -1 && source.indexOf("_zips") == -1) {
					usi_appender = (source.indexOf("?")==-1?"?":"&");
					if (source.indexOf("pv2.js") != -1) usi_appender = "%7C";
					usi_appender += "si=" + usi_commons.get_sess();
				}
				newScript.src = source + usi_appender;
				if (typeof callback == "function") {
					newScript.onload = function() {
						try {
							callback();
						} catch (e) {
							usi_commons.report_error(e);
						}
					};
				}
				docHead.appendChild(newScript);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_display:function(usiQS, usiSiteID, usiKey, callback) {
			try {
				usiKey = usiKey || "";
				var source = usi_commons.domain + "/launch.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&keys=" + usiKey;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_view:function(usiHash, usiSiteID, usiKey, callback) {
			try {
				if (typeof(usi_force) != "undefined" || location.href.indexOf("usi_force") != -1 || (usi_cookies.get("usi_sale") == null && usi_cookies.get("usi_launched") == null && usi_cookies.get("usi_launched"+usiSiteID) == null)) {
					usiKey = usiKey || "";
					var usi_append = "";
					if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
					else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
					if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
					var source = usi_commons.domain + "/view.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
					if (typeof(usi_commons.last_view) !== "undefined" && usi_commons.last_view == usiSiteID+"_"+usiKey) return;
					usi_commons.last_view = usiSiteID+"_"+usiKey;
					if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') usi_js.cleanup();
					usi_commons.load_script(source, callback);
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		remove_loads:function() {
			try {
				if (document.getElementById("usi_obj") != null) {
					document.getElementById("usi_obj").parentNode.parentNode.removeChild(document.getElementById("usi_obj").parentNode);
				}
				if (typeof(usi_commons.usi_loads) !== "undefined") {
					for (var i in usi_commons.usi_loads) {
						if (document.getElementById("usi_"+i) != null) {
							document.getElementById("usi_"+i).parentNode.parentNode.removeChild(document.getElementById("usi_"+i).parentNode);
						}
					}
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load:function(usiHash, usiSiteID, usiKey, callback){
			try {
				if (typeof(window["usi_" + usiSiteID]) !== "undefined") return;
				usiKey = usiKey || "";
				var usi_append = "";
				if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
				else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
				if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
				var source = usi_commons.domain + "/usi_load.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
				usi_commons.load_script(source, callback);
				if (typeof(usi_commons.usi_loads) === "undefined") {
					usi_commons.usi_loads = {};
				}
				usi_commons.usi_loads[usiSiteID] = usiSiteID;
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_precapture:function(usiQS, usiSiteID, callback) {
			try {
				var source = usi_commons.domain + "/hound/monitor.jsp?qs=" + usiQS + "&siteID=" + usiSiteID;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_mail:function(qs, siteID, callback) {
			try {
				var source = usi_commons.domain + "/mail.jsp?qs=" + qs + "&siteID=" + siteID + "&domain=" + encodeURIComponent(usi_commons.domain);
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		send_prod_rec:function(siteID, info, real_time) {
			var result = false;
			try {
				if (document.getElementsByTagName("html").length > 0 && document.getElementsByTagName("html")[0].className != null && document.getElementsByTagName("html")[0].className.indexOf("translated") != -1) {
					//Ignore translated pages
					return false;
				}
				var data = [siteID, info.name, info.link, info.pid, info.price, info.image];
				if (data.indexOf(undefined) == -1) {
					var queryString = [siteID, info.name.replace(/\|/g, "&#124;"), info.link, info.pid, info.price, info.image].join("|") + "|";
					if (info.extra) queryString += info.extra + "|";
					var filetype = real_time ? "jsp" : "js";
					usi_commons.load_script(usi_commons.domain + "/utility/pv2." + filetype + "?" + encodeURIComponent(queryString));
					result = true;
				}
			} catch (e) {
				usi_commons.report_error(e);
				result = false;
			}
			return result;
		},
		report_error:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
			usi_commons.log_error(err.message);
			usi_commons.dir(err);
		},
		report_error_no_console:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
		},
		gup_or_get_cookie: function(name, expireSeconds, forceCookie) {
			try {
				if (typeof usi_cookies === 'undefined') {
					usi_commons.log_error('usi_cookies is not defined');
					return;
				}
				expireSeconds = (expireSeconds || usi_cookies.expire_time.day);
				if (name == "usi_enable") expireSeconds = usi_cookies.expire_time.hour;
				var value = null;
				var qsValue = usi_commons.gup(name);
				if (qsValue !== '') {
					value = qsValue;
					usi_cookies.set(name, value, expireSeconds, forceCookie);
				} else {
					value = usi_cookies.get(name);
				}
				return (value || '');
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		get_sess: function() {
			var usi_si = null;
			if (typeof(usi_cookies) === "undefined") return "";
			try {
				if (usi_cookies.get('usi_si') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_si = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_si', usi_si, 24*60*60);
					return usi_si;
				}
				if (usi_cookies.get('usi_si') != null) usi_si = usi_cookies.get('usi_si');
				usi_cookies.set('usi_si', usi_si, 24*60*60);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_si;
		},
		get_id: function(usi_append) {
			if (!usi_append) usi_append = "";
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_v') == null && usi_cookies.get('usi_id'+usi_append) == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_v') != null) usi_id = usi_cookies.get('usi_v');
				if (usi_cookies.get('usi_id'+usi_append) != null) usi_id = usi_cookies.get('usi_id'+usi_append);
				usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		load_session_data: function(extended) {
			try {
				if (usi_cookies.get_json("usi_session_data") == null) {
					usi_commons.load_script(usi_commons.domain + '/utility/session_data.jsp?extended=' + (extended?"true":"false"));
				} else {
					usi_app.session_data = usi_cookies.get_json("usi_session_data");
					if (typeof(usi_app.session_data_callback) !== "undefined") {
						usi_app.session_data_callback();
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		}
	};
	setTimeout(function() {
		try {
			if (usi_commons.gup_or_get_cookie("usi_debug") != "") usi_commons.debug = true;
			if (usi_commons.gup_or_get_cookie("usi_qa") != "") {
				usi_commons.domain = usi_commons.cdn = "https://prod.upsellit.com";
			}
		} catch(err) {
			usi_commons.report_error(err);
		}
	}, 1000);
}
if("undefined"==typeof usi_cookies&&(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,o,i){try{var n=-1;if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n=t.getTime()}var r=window.top||window,s=0;null!=o&&-1!=o.indexOf("=")&&(o=o.replace(new RegExp("=","g"),"USIEQLS")),null!=o&&-1!=o.indexOf(";")&&(o=o.replace(new RegExp(";","g"),"USIPRNS"));for(var a=r.name.split(";"),u="",c=0;c<a.length;c++){var l=a[c].split("=");3==l.length?(l[0]==e&&(l[1]=o,l[2]=n,s=1),null!=l[1]&&"null"!=l[1]&&(u+=l[0]+"="+l[1]+"="+l[2]+";")):""!=a[c]&&(u+=a[c]+";")}0==s&&(u+=e+"="+o+"="+n+";"),r.name=u}catch(e){}},flush_window_name:function(e){try{for(var o=window.top||window,i=o.name.split(";"),n="",t=0;t<i.length;t++){var r=i[t].split("=");3==r.length&&(0==r[0].indexOf(e)||(n+=i[t]+";"))}o.name=n}catch(e){}},get_from_window_name:function(e){try{for(var o,i=(window.top||window).name.split(";"),n=0;n<i.length;n++){var t=i[n].split("=");if(3==t.length){if(t[0]==e&&(-1!=(o=t[1]).indexOf("USIEQLS")&&(o=o.replace(new RegExp("USIEQLS","g"),"=")),-1!=o.indexOf("USIPRNS")&&(o=o.replace(new RegExp("USIPRNS","g"),";")),!("-1"!=t[2]&&usi_cookies.datediff(t[2])<0)))return[o,t[2]]}else if(2==t.length&&t[0]==e)return-1!=(o=t[1]).indexOf("USIEQLS")&&(o=o.replace(new RegExp("USIEQLS","g"),"=")),-1!=o.indexOf("USIPRNS")&&(o=o.replace(new RegExp("USIPRNS","g"),";")),[o,(new Date).getTime()+6048e5]}}catch(e){}return null},datediff:function(e){return e-(new Date).getTime()},count_cookies:function(e){return e=e||"usi_",usi_cookies.search_cookies(e).length},root_domain:function(){try{var e=document.domain.split("."),o=e[e.length-1];if("com"==o||"net"==o||"org"==o||"us"==o||"co"==o||"ca"==o)return e[e.length-2]+"."+e[e.length-1]}catch(e){}return document.domain},create_cookie:function(e,o,i){if(!1!==navigator.cookieEnabled){var n="";if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n="; expires="+t.toGMTString()}var r="samesite=none;";0==location.href.indexOf("https://")&&(r+="secure;");var s=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(s=usi_parent_domain),document.cookie=e+"="+encodeURIComponent(o)+n+"; path=/;domain="+s+"; "+r}},create_nonencoded_cookie:function(e,o,i){if(!1!==navigator.cookieEnabled){var n="";if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n="; expires="+t.toGMTString()}var r="samesite=none;";0==location.href.indexOf("https://")&&(r+="secure;");var s=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(s=usi_parent_domain),document.cookie=e+"="+o+n+"; path=/;domain="+s+"; "+r}},read_cookie:function(e){if(!1===navigator.cookieEnabled)return null;var o=e+"=",i=[];try{i=document.cookie.split(";")}catch(e){}for(var n=0;n<i.length;n++){for(var t=i[n];" "==t.charAt(0);)t=t.substring(1,t.length);if(0==t.indexOf(o))return decodeURIComponent(t.substring(o.length,t.length))}return null},del:function(e){usi_cookies.set(e,null,-100);try{null!=localStorage&&localStorage.removeItem(e),null!=sessionStorage&&sessionStorage.removeItem(e)}catch(e){}},get_ls:function(e){try{var o=localStorage.getItem(e);if(null!=o){if(0==o.indexOf("{")&&-1!=o.indexOf("usi_expires")){var i=JSON.parse(o);if((new Date).getTime()>i.usi_expires)return localStorage.removeItem(e),null;o=i.value}return decodeURIComponent(o)}}catch(e){}return null},get:function(e){var o=usi_cookies.read_cookie(e);if(null!=o)return o;try{if(null!=localStorage&&null!=(o=usi_cookies.get_ls(e)))return o;if(null!=sessionStorage&&null!=(o=sessionStorage.getItem(e)))return decodeURIComponent(o)}catch(e){}var i=usi_cookies.get_from_window_name(e);if(null!=i&&i.length>1)try{o=decodeURIComponent(i[0])}catch(e){return i[0]}return o},get_json:function(e){var o=null,i=usi_cookies.get(e);if(null==i)return null;try{o=JSON.parse(i)}catch(e){i=i.replace(/\\"/g,'"');try{o=JSON.parse(JSON.parse(i))}catch(e){try{o=JSON.parse(i)}catch(e){}}}return o},search_cookies:function(e){e=e||"";var o=[];return document.cookie.split(";").forEach((function(i){var n=i.split("=")[0].trim();""!==e&&0!==n.indexOf(e)||o.push(n)})),o},set:function(e,o,i,n){"undefined"!=typeof usi_nevercookie&&(n=!1),void 0===i&&(i=-1);try{o=o.replace(/(\r\n|\n|\r)/gm,"")}catch(e){}"undefined"==typeof usi_windownameless&&usi_cookies.update_window_name(e+"",o+"",i);try{if(i>0&&null!=localStorage){var t={value:o,usi_expires:(new Date).getTime()+1e3*i};localStorage.setItem(e,JSON.stringify(t))}else null!=sessionStorage&&sessionStorage.setItem(e,o)}catch(e){}if(n||null==o){if(null!=o){if(null==usi_cookies.read_cookie(e))if(!n)if(usi_cookies.search_cookies("usi_").length+1>usi_cookies.max_cookies_count)return void usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+usi_cookies.max_cookies_count);if(o.length>usi_cookies.max_cookie_length)return void usi_cookies.report_error('Cookie "'+e+'" truncated ('+o.length+"). Max single-cookie length is "+usi_cookies.max_cookie_length)}usi_cookies.create_cookie(e,o,i)}},set_json:function(e,o,i,n){var t=JSON.stringify(o).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,t,i,n)},flush:function(e){e=e||"usi_";var o,i,n,t=document.cookie.split(";");for(o=0;o<t.length;o++)0==(i=t[o]).trim().toLowerCase().indexOf(e)&&(n=i.trim().split("=")[0],usi_cookies.del(n));usi_cookies.flush_window_name(e);try{if(null!=localStorage)for(var r in localStorage)0==r.indexOf("usi_")&&localStorage.removeItem(r);if(null!=sessionStorage)for(var r in sessionStorage)0==r.indexOf("usi_")&&sessionStorage.removeItem(r)}catch(e){}},print:function(){for(var e=document.cookie.split(";"),o="",i=0;i<e.length;i++){var n=e[i];0==n.trim().toLowerCase().indexOf("usi_")&&(console.log(decodeURIComponent(n.trim())+" (cookie)"),o+=","+n.trim().toLowerCase().split("=")[0]+",")}try{if(null!=localStorage)for(var t in localStorage)0==t.indexOf("usi_")&&"string"==typeof localStorage[t]&&-1==o.indexOf(","+t+",")&&(console.log(t+"="+usi_cookies.get_ls(t)+" (localStorage)"),o+=","+t+",");if(null!=sessionStorage)for(var t in sessionStorage)0==t.indexOf("usi_")&&"string"==typeof sessionStorage[t]&&-1==o.indexOf(","+t+",")&&(console.log(t+"="+sessionStorage[t]+" (sessionStorage)"),o+=","+t+",")}catch(e){}for(var r=(window.top||window).name.split(";"),s=0;s<r.length;s++){var a=r[s].split("=");if(3==a.length&&0==a[0].indexOf("usi_")&&-1==o.indexOf(","+a[0]+",")){var u=a[1];-1!=u.indexOf("USIEQLS")&&(u=u.replace(new RegExp("USIEQLS","g"),"=")),-1!=u.indexOf("USIPRNS")&&(u=u.replace(new RegExp("USIPRNS","g"),";")),console.log(a[0]+"="+u+" (window.name)"),o+=","+n.trim().toLowerCase().split("=")[0]+","}}},value_exists:function(){var e,o;for(e=0;e<arguments.length;e++)if(""===(o=usi_cookies.get(arguments[e]))||null===o||"null"===o||"undefined"===o)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}},"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.gup&&"function"==typeof usi_commons.gup_or_get_cookie))try{""!=usi_commons.gup("usi_email_id")?usi_cookies.set("usi_email_id",usi_commons.gup("usi_email_id").split(".")[0],Number(usi_commons.gup("usi_email_id").split(".")[1]),!0):null==usi_cookies.read_cookie("usi_email_id")&&null!=usi_cookies.get_from_window_name("usi_email_id")&&(usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?usi_email_id_fix="+encodeURIComponent(usi_cookies.get_from_window_name("usi_email_id")[0])),usi_cookies.set("usi_email_id",usi_cookies.get_from_window_name("usi_email_id")[0],(usi_cookies.get_from_window_name("usi_email_id")[1]-(new Date).getTime())/1e3,!0)),""!=usi_commons.gup_or_get_cookie("usi_debug")&&(usi_commons.debug=!0),""!=usi_commons.gup_or_get_cookie("usi_qa")&&(usi_commons.domain=usi_commons.cdn="https://prod.upsellit.com")}catch(e){usi_commons.report_error(e)}
"undefined"==typeof usi_dom&&(usi_dom={},usi_dom.get_elements=function(e,t){return t=t||document,Array.prototype.slice.call(t.querySelectorAll(e))},usi_dom.count_elements=function(e,t){return t=t||document,usi_dom.get_elements(e,t).length},usi_dom.get_nth_element=function(e,t,n){var o=null;n=n||document;var r=usi_dom.get_elements(t,n);return r.length>=e&&(o=r[e-1]),o},usi_dom.get_first_element=function(e,t){if(""===(e||""))return null;if(t=t||document,"[object Array]"===Object.prototype.toString.call(e)){for(var n=null,o=0;o<e.length;o++){var r=e[o];if(null!=(n=usi_dom.get_first_element(r,t)))break}return n}return t.querySelector(e)},usi_dom.get_element_text_no_children=function(e,t){var n="";if(null==t&&(t=!1),null!=(e=e||document)&&null!=e.childNodes)for(var o=0;o<e.childNodes.length;++o)3===e.childNodes[o].nodeType&&(n+=e.childNodes[o].textContent);return!0===t&&(n=usi_dom.clean_string(n)),n.trim()},usi_dom.clean_string=function(e){if("string"==typeof e){return(e=(e=(e=(e=(e=(e=(e=e.replace(/[\u2010-\u2015\u2043]/g,"-")).replace(/[\u2018-\u201B]/g,"'")).replace(/[\u201C-\u201F]/g,'"')).replace(/\u2024/g,".")).replace(/\u2025/g,"..")).replace(/\u2026/g,"...")).replace(/\u2044/g,"/")).replace(/[^\x20-\xFF\u0100-\u017F\u0180-\u024F\u20A0-\u20CF]/g,"").trim()}},usi_dom.encode=function(e){if("string"==typeof e){var t=encodeURIComponent(e);return t=t.replace(/[-_.!~*'()]/g,function(e){return"%"+e.charCodeAt(0).toString(16).toUpperCase()})}},usi_dom.get_closest=function(e,t){for(e=e||document,"function"!=typeof Element.prototype.matches&&(Element.prototype.matches=Element.prototype.matchesSelector||Element.prototype.mozMatchesSelector||Element.prototype.msMatchesSelector||Element.prototype.oMatchesSelector||Element.prototype.webkitMatchesSelector||function(e){for(var t=(this.document||this.ownerDocument).querySelectorAll(e),n=t.length;--n>=0&&t.item(n)!==this;);return n>-1});null!=e&&e!==document;e=e.parentNode)if(e.matches(t))return e;return null},usi_dom.get_classes=function(e){var t=[];return null!=e&&null!=e.classList&&(t=Array.prototype.slice.call(e.classList)),t},usi_dom.add_class=function(e,t){if(null!=e){var n=usi_dom.get_classes(e);-1===n.indexOf(t)&&(n.push(t),e.className=n.join(" "))}},usi_dom.string_to_decimal=function(e){var t=null;if("string"==typeof e)try{var n=parseFloat(e.replace(/[^0-9\.-]+/g,""));!1===isNaN(n)&&(t=n)}catch(e){usi_commons.log("Error: "+e.message)}return t},usi_dom.string_to_integer=function(e){var t=null;if("string"==typeof e)try{var n=parseInt(e.replace(/[^0-9-]+/g,""));!1===isNaN(n)&&(t=n)}catch(e){usi_commons.log("Error: "+e.message)}return t},usi_dom.get_currency_string_from_content=function(e){if("string"!=typeof e)return"";try{e=e.trim();var t=e.match(/^([^\$]*?)(\$(?:[\,\,]?\d{1,3})+(?:\.\d{2})?)(.*?)$/)||[];return 4===t.length?t[2]:""}catch(e){return usi_commons.log("Error: "+e.message),""}},usi_dom.get_absolute_url=function(){var e;return function(t){return(e=e||document.createElement("a")).href=t,e.href}}(),usi_dom.format_number=function(e,t){var n="";if("number"==typeof e){t=t||0;var o=e.toFixed(t).split(/\./g);if(1==o.length||2==o.length)n=o[0].replace(/./g,function(e,t,n){return t&&"."!==e&&(n.length-t)%3==0?","+e:e}),2==o.length&&(n+="."+o[1])}return n},usi_dom.format_currency=function(e,t,n){var o="";return e=Number(e),!1===isNaN(e)&&("object"==typeof Intl&&"function"==typeof Intl.NumberFormat?(t=t||"en-US",n=n||{style:"currency",currency:"USD"},o=e.toLocaleString(t,n)):o=e),o},usi_dom.to_decimal_places=function(e,t){if(null!=e&&"number"==typeof e&&null!=t&&"number"==typeof t){if(0==t)return parseFloat(Math.round(e));for(var n=10,o=1;o<t;o++)n*=10;return parseFloat(Math.round(e*n)/n)}return null},usi_dom.trim_string=function(e,t,n){return n=n||"",(e=e||"").length>t&&(e=e.substring(0,t),""!==n&&(e+=n)),e},usi_dom.attach_event=function(e,t,n){var o=usi_dom.find_supported_element(e,n);usi_dom.detach_event(e,t,o),o.addEventListener?o.addEventListener(e,t,!1):o.attachEvent("on"+e,t)},usi_dom.detach_event=function(e,t,n){var o=usi_dom.find_supported_element(e,n);o.removeEventListener?o.removeEventListener(e,t,!1):o.detachEvent("on"+e,t)},usi_dom.find_supported_element=function(e,t){return(t=t||document)===window?window:!0===usi_dom.is_event_supported(e,t)?t:t===document?window:usi_dom.find_supported_element(e,document)},usi_dom.is_event_supported=function(e,t){return null!=t&&void 0!==t["on"+e]},usi_dom.is_defined=function(e,t){if(null==e)return!1;if(""===(t||""))return!1;var n=!0,o=e;return t.split(".").forEach(function(e){!0===n&&(null==o||"object"!=typeof o||!1===o.hasOwnProperty(e)?n=!1:o=o[e])}),n},usi_dom.observe=function(e,t,n){var o=location.href,r=window.MutationObserver||window.WebkitMutationObserver;return t=t||{onUrlUpdate:!1,observerOptions:{childList:!0,subtree:!0}},function(e,n){var i=null,u=function(){var e=location.href;t.onUrlUpdate&&e!==o?(n(),o=e):n()};return r?(i=new r(function(e){var r=location.href,i=e[0].addedNodes.length||e[0].removedNodes.length;i&&t.onUrlUpdate&&r!==o?(n(),o=r):i&&n()})).observe(e,t.observerOptions):window.addEventListener&&(e.addEventListener("DOMNodeInserted",u,!1),e.addEventListener("DOMNodeRemoved",u,!1)),i}}(),usi_dom.params_to_object=function(e){var t={};""!=(e||"")&&e.split("&").forEach(function(e){var n=e.split("=");2===n.length?t[decodeURIComponent(n[0])]=decodeURIComponent(n[1]):1===n.length&&(t[decodeURIComponent(n[0])]=null)});return t},usi_dom.object_to_params=function(e){var t=[];if(null!=e)for(var n in e)!0===e.hasOwnProperty(n)&&t.push(encodeURIComponent(n)+"="+(null==e[n]?"":encodeURIComponent(e[n])));return t.join("&")},usi_dom.interval_with_timeout=function(e,t,n,o){if("function"!=typeof e)throw new Error("usi_dom.interval_with_timeout(): iterationFunction must be a function");if(null==t)t=function(e){return e};else if("function"!=typeof t)throw new Error("usi_dom.interval_with_timeout(): timeoutCallback must be a function");if(null==n)n=function(e){return e};else if("function"!=typeof n)throw new Error("usi_dom.interval_with_timeout(): completeCallback must be a function");var r=(o=o||{}).intervalMS||20,i=o.timeoutMS||2e3;if("number"!=typeof r)throw new Error("usi_dom.interval_with_timeout(): intervalMS must be a number");if("number"!=typeof i)throw new Error("usi_dom.interval_with_timeout(): timeoutMS must be a number");var u=!1,l=new Date,a=setInterval(function(){var o=new Date-l;if(o>=i)return clearInterval(a),t({elapsedMS:o});!1===u&&(u=!0,e(function(e,t){if(u=!1,!0===e)return clearInterval(a),(t=t||{}).elapsedMS=new Date-l,n(t)}))},r)},usi_dom.load_external_stylesheet=function(e,t,n){if(""!==(e||"")){""===(t||"")&&(t="usi_stylesheet_"+(new Date).getTime());var o={url:e,id:t},r=document.getElementsByTagName("head")[0];if(null!=r){var i=document.createElement("link");i.type="text/css",i.rel="stylesheet",i.id=o.id,i.href=e,usi_dom.attach_event("load",function(){if(null!=n)return n(null,o)},i),r.appendChild(i)}}else if(null!=n)return n(null,o)},usi_dom.ready=function(e){void 0!==document.readyState&&"complete"===document.readyState?e():window.addEventListener?window.addEventListener("load",e,!0):window.attachEvent?window.attachEvent("onload",e):setTimeout(e,5e3)},usi_dom.fit_text=function(e,t){t||(t={});var n={multiLine:!0,minFontSize:.1,maxFontSize:20,widthOnly:!1},o={};for(var r in n)t.hasOwnProperty(r)?o[r]=t[r]:o[r]=n[r];var i=Object.prototype.toString.call(e);function u(e,t){var n,o,r,i,u,l,a,s;r=e.innerHTML,u=parseInt(window.getComputedStyle(e,null).getPropertyValue("font-size"),10),i=function(e){var t=window.getComputedStyle(e,null);return(e.clientWidth-parseInt(t.getPropertyValue("padding-left"),10)-parseInt(t.getPropertyValue("padding-right"),10))/u}(e),o=function(e){var t=window.getComputedStyle(e,null);return(e.clientHeight-parseInt(t.getPropertyValue("padding-top"),10)-parseInt(t.getPropertyValue("padding-bottom"),10))/u}(e),i&&(t.widthOnly||o)||(t.widthOnly?usi_commons.log("Set a static width on the target element "+e.outerHTML):usi_commons.log("Set a static height and width on the target element "+e.outerHTML)),-1===r.indexOf("textFitted")?((n=document.createElement("span")).className="textFitted",n.style.display="inline-block",n.innerHTML=r,e.innerHTML="",e.appendChild(n)):n=e.querySelector("span.textFitted"),t.multiLine||(e.style["white-space"]="nowrap"),l=t.minFontSize,s=t.maxFontSize;for(var c=l,d=1e3;l<=s&&d>0;)d--,a=s+l-.1,n.style.fontSize=a+"em",n.scrollWidth/u<=i&&(t.widthOnly||n.scrollHeight/u<=o)?(c=a,l=a+.1):s=a-.1;n.style.fontSize!==c+"em"&&(n.style.fontSize=c+"em")}"[object Array]"!==i&&"[object NodeList]"!==i&&"[object HTMLCollection]"!==i&&(e=[e]);for(var l=0;l<e.length;l++)u(e[l],o)});
"undefined"==typeof usi_ajax&&(usi_ajax={},usi_ajax.get=function(e,t){try{return usi_ajax.get_with_options({url:e},t)}catch(e){usi_commons.report_error(e)}},usi_ajax.get_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],null==XMLHttpRequest)return t(new Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(new Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("GET",e.url,!0),a.setRequestHeader("Content-type","application/json"),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=new Error("http.status: "+a.status)),t(e,r)}},a.send()}catch(e){return usi_commons.report_error(e),t(e,r)}},usi_ajax.post=function(e,t,r){try{return usi_ajax.post_with_options({url:e,params:t},r)}catch(e){usi_commons.report_error(e)}},usi_ajax.post_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],e.paramsDataType=e.paramsDataType||"string",e.params=e.params||"",null==XMLHttpRequest)return t(new Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(new Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("POST",e.url,!0),"formData"===e.paramsDataType||("object"===e.paramsDataType?(a.setRequestHeader("Content-type","application/json; charset=utf-8"),e.params=JSON.stringify(e.params)):a.setRequestHeader("Content-type","application/x-www-form-urlencoded")),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"",r.responseURL=a.responseURL||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=new Error("http.status: "+a.status)),t(e,r)}},a.send(e.params)}catch(e){return usi_commons.report_error(e),t(e,r)}},usi_ajax.form_post=function(e,t,r){try{r=r||"post";var a=document.createElement("form");a.setAttribute("method",r),a.setAttribute("action",e),null!=t&&"object"==typeof t&&Object.keys(t).forEach(function(e){var r=document.createElement("input");r.setAttribute("type","hidden"),r.setAttribute("name",e),r.setAttribute("value",t[e]),a.appendChild(r)}),document.body.appendChild(a),a.submit()}catch(e){usi_commons.report_error(e)}},usi_ajax.put_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],null==XMLHttpRequest)return t(new Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(new Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("PUT",e.url,!0),a.setRequestHeader("Content-type","application/json"),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=new Error("http.status: "+a.status)),t(e,r)}},a.send()}catch(e){return usi_commons.report_error(e),t(e,r)}},usi_ajax.get_with_script=function(e,t,r){try{var a={};null==t&&(t=!0);var n="usi_"+(new Date).getTime(),s=document.getElementsByTagName("head")[0];top.location!=location&&(s=parent.document.getElementsByTagName("head")[0]);var o=document.createElement("script");o.id=n,o.type="text/javascript",o.src=e,o.addEventListener("load",function(){if(!0===t&&s.removeChild(o),null!=r)return r(null,a)}),s.appendChild(o)}catch(e){usi_commons.report_error(e)}},usi_ajax.listener=function(e){if(null==e&&(e=!1),null!=XMLHttpRequest){var t=this;t.ajax=new Object,t.clear=function(){t.ajax.requests=[],t.ajax.registeredRequests=[],t.ajax.scriptLoads=[],t.ajax.registeredScriptLoads=[]},t.clear(),t.register=function(e,r,a){try{var n={method:e=(e||"*").toUpperCase(),url:r=r||"*",callback:a=a||function(){}};t.ajax.registeredRequests.push(n)}catch(e){usi_commons.report_error(e)}},t.registerScriptLoad=function(e,r){try{var a={url:e=e||"*",callback:r=r||function(){}};t.ajax.registeredScriptLoads.push(a)}catch(e){usi_commons.report_error(e)}},t.registerFormSubmit=function(t,r){try{null!=t&&usi_dom.attach_event("submit",function(a){if(!0===e&&usi_commons.log("USI AJAX: form submit"),null!=a&&!0===a.returnValue){a.preventDefault();var n={action:t.action,data:{},e:a},s=["submit"];if(Array.prototype.slice.call(t.elements).forEach(function(e){try{-1===s.indexOf(e.type)&&("checkbox"===e.type?!0===e.checked&&(n.data[e.name]=e.value):n.data[e.name]=e.value)}catch(e){usi_commons.report_error(e)}}),null!=r)return r(null,n);a.returnValue=!0}},t)}catch(e){usi_commons.report_error(e)}},t.listen=function(){try{t.ajax.originalOpen=XMLHttpRequest.prototype.open,t.ajax.originalSend=XMLHttpRequest.prototype.send,XMLHttpRequest.prototype.open=function(r,a){r=(r||"").toUpperCase(),a=a||"",a=usi_dom.get_absolute_url(a),!0===e&&usi_commons.log("USI AJAX: open["+r+"]: "+a);var n={method:r,url:a,openDate:new Date};t.ajax.requests.push(n);var s=null;t.ajax.registeredRequests.forEach(function(e){e.method!=r&&"*"!=e.method||(a.indexOf(e.url)>-1||"*"==e.url)&&(s=e)}),null!=s&&(!0===e&&usi_commons.log("USI AJAX: Registered URL["+r+"]: "+a),this.requestObj=n,this.requestObj.callback=s.callback),t.ajax.originalOpen.apply(this,arguments)},XMLHttpRequest.prototype.send=function(r){var a=this;null!=a.requestObj&&(!0===e&&usi_commons.log("USI AJAX: Send Registered URL["+a.requestObj.method+"]: "+a.requestObj.url),""!=(r||"")&&(a.requestObj.params=r),a.addEventListener?a.addEventListener("readystatechange",function(){t.ajax.readyStateChanged(a)},!1):t.ajax.proxifyOnReadyStateChange(a)),t.ajax.originalSend.apply(a,arguments)},t.ajax.readyStateChanged=function(t){if(4===t.readyState&&null!=t.requestObj&&(t.requestObj.completedDate=new Date,!0===e&&usi_commons.log("Completed: "+t.requestObj.url),null!=t.requestObj.callback)){var r={requestObj:t.requestObj,responseText:t.responseText};return t.requestObj.callback(null,r)}},t.ajax.proxifyOnReadyStateChange=function(e){var r=e.onreadystatechange;null!=r&&(e.onreadystatechange=function(){t.ajax.readyStateChanged(e),r()})},document.head.addEventListener("load",function(e){if(null!=e&&null!=e.target&&""!=(e.target.src||"")){var r=e.target.src,a={url:r=usi_dom.get_absolute_url(r),completedDate:new Date};t.ajax.scriptLoads.push(a);var n=null;if(t.ajax.registeredScriptLoads.forEach(function(e){(r.indexOf(e.url)>-1||"*"==e.url)&&(n=e)}),null!=n&&null!=n.callback)return n.callback(null,a)}},!0),usi_commons.log("USI AJAX: listening ...")}catch(e){usi_commons.report_error(e),usi_commons.log("usi_ajax.listener ERROR: "+e.message)}},t.unregisterAll=function(){t.ajax.registeredRequests=[],t.ajax.registeredScriptLoads=[]}}});
"undefined"==typeof usi_data&&(usi_data={},usi_data.data_store=function(e){this.keyFieldName=e,this.cookieName="usi_data_"+e,this.items=usi_cookies.get_json(this.cookieName)||[],this.get_item=function(e){return usi_array.get_item(this.items,this.keyFieldName,e)},this.save_value=function(e,t,i){var s=this.get_item(e);return null==s&&((s={})[this.keyFieldName]=e,this.items.push(s)),s[t]=i,usi_cookies.set_json(this.cookieName,this.items,usi_cookies.expire_time.day),s},this.get_value=function(e,t){var i=null,s=this.get_item(e);return null!=s&&1==s.hasOwnProperty(t)&&(i=s[t]),i},this.attach_metadata=function(e){var t=null;if(null!=e&&1==e.hasOwnProperty(this.keyFieldName)&&null!=(t=this.get_item(e[this.keyFieldName])))for(var i in t)1==t.hasOwnProperty(i)&&(e[i]=t[i]);return t}},usi_data.new_guid=function(){return"xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g,function(e){var t=16*Math.random()|0;return("x"==e?t:3&t|8).toString(16)})},usi_data.get_session_id=function(){var e=null;return null!=usi_cookies.get("USI_Session")?e=usi_cookies.get("USI_Session"):null!=usi_cookies.get("USI_DataHound")?e=usi_cookies.get("USI_DataHound"):null!=usi_cookies.get("usi_sess")?e=usi_cookies.get("usi_sess"):(e="usi_sess_"+usi_data.new_guid(),usi_cookies.set("usi_sess",e,usi_cookies.expire_time.day)),e},usi_data.save_session_data=function(e,t,i,s){var n={};i=i||"0";var a=usi_data.get_session_id(),o=usi_commons.domain+"/hound/saveData.jsp?siteID="+i+"&USI_value="+encodeURIComponent(t)+"&USI_name="+encodeURIComponent(e)+"&USI_Session="+encodeURIComponent(a);usi_ajax.get_with_script(o,!0,function(e,t){return null!=e&&null!=s?s(e,n):null!=s?s(null,n):void 0})},usi_data.save_session_items=function(e,t,i){var s={sessionID:usi_data.get_session_id()};t=t||"0";var n=0;e.forEach(function(a){usi_data.save_session_data(a.name,a.value,t,function(t,a){if((n+=1)==e.length&&(usi_commons.log("Saved Session items: "+s.sessionID),null!=i))return i(s)})})},usi_data.get_session_data=function(e,t){var i=usi_commons.domain+"/hound/getSessionData.jsp?s="+e,s="usi_"+(new Date).getTime();if(""!==e){var n=document.getElementsByTagName("head")[0];top.location!=location&&(n=parent.document.getElementsByTagName("head")[0]);var a=document.createElement("script");a.id=s,a.type="text/javascript",a.src=i,a.addEventListener("load",function(){var i=null;if("undefined"!=typeof usi_data&&void 0!==usi_data.sessionData&&(i=usi_data.sessionData[e]||null),n.removeChild(a),null!=t)return t(null,i)}),n.appendChild(a)}},usi_data.is_item_on_list=function(e,t,i,s,n){var a={};if(""===(e||"")&&null!=callback)return callback(new Error("companyID cannot be blank."),a);if(""===(i||"")&&null!=callback)return callback(new Error("item cannot be blank."),a);var o=usi_commons.cdn+"/utility/lookup_suppression.jsp?companyID="+e+"&product="+encodeURIComponent(i);""!==(t||"")&&(o+="&label="+encodeURIComponent(t)),""!==(s||"")&&(o+="&callback="+encodeURIComponent(s));var u=usi_dom.object_to_params(n);""!=u&&(o+="&"+u);var _="usi_"+(new Date).getTime(),l=document.getElementsByTagName("head")[0];top.location!=location&&(l=parent.document.getElementsByTagName("head")[0]);var r=document.createElement("script");r.id=_,r.type="text/javascript",r.src=o,r.addEventListener("load",function(){l.removeChild(r)}),l.appendChild(r)},usi_data.get_qs_or_cookie_item=function(e,t){t=t||usi_cookies.expire_time.day;var i=null,s=usi_commons.gup(e);return""!==s?(i=s,usi_cookies.set(e,i,t)):i=usi_cookies.get(e),i||""},usi_data.build_form_data_object=function(e,t){var i=null;return null==t&&(t=!0),null!=e&&(i={},usi_dom.get_elements("*",e).forEach(function(e){if(e.hasAttribute("name")){var s=e.getAttribute("name")||"";if(""!==s){var n=e.value||"";(""!==n||t)&&(i[s]=n)}}})),i});
'undefined'==typeof usi_url&&(usi_url={},usi_url.URL=function(a){a=a||location.href;var b=document.createElement('a');if(b.href=a,this.full=b.href||'',this.protocol=(b.protocol||'').split(':')[0],this.host=b.host||'',-1!=this.host.indexOf(':')&&(this.host=this.host.substring(0,this.host.indexOf(':'))),this.port=b.port||'',this.hash=b.hash||'',this.baseURL='',this.tld='',this.domain='',this.subdomain='',this.domain_tld='',''!==this.protocol&&''!==this.host){this.baseURL=this.protocol+'://'+this.host+'/';var c=this.host.split(/\./g);if(2<=c.length){if(-1<['co','com','org','net','int','edu','gov','mil'].indexOf(c[c.length-2])&&2===c[c.length-1].length){var d=c.pop(),e=c.pop();this.tld=e+'.'+d}else this.tld=c.pop()}0<c.length&&(this.domain=c.pop(),0<c.length&&(this.subdomain=c.join('.'))),this.domain_tld=this.domain+'.'+this.tld}var f=b.pathname||'';0!==f.indexOf('/')&&(f='/'+f),this.path=new usi_url.Path(f),this.params=new usi_url.Params((b.search||'').substr(1))},usi_url.URL.prototype.build=function(a,b,c){var d='';return''!==this.protocol&&''!==this.host&&(null==a&&(a=!0),null==b&&(b=!0),null==c&&(c=!0),!0==a&&(d+=this.protocol+':'),d+='//'+this.host,''!==this.port&&(d+=':'+this.port),!0==b&&(d+=this.path.full,!0==c&&0<Object.keys(this.params.parameters).length&&(d+='?',d+=this.params.build()))),d},usi_url.Path=function(a){a=a||'',this.full=a,this.directories=[],this.filename='';for(var b=a.substr(1).split(/\//g);0<b.length;)1===b.length?this.filename=b.shift():this.directories.push(b.shift());this.has_directory=function(a){return-1<this.directories.indexOf(a)},this.contains=function(a){return-1<this.full.indexOf(a)}},usi_url.Params=function(a){a=a||'',this.full=a,this.parameters=function(a){var b={};if(1===a.length&&''===a[0])return b;for(var c,d,e,f=0;f<a.length;f++)if(e=a[f].split('='),c=e[0]&&e[0].replace(/\+/g,' '),d=e[1]&&e[1].replace(/\+/g,' '),1===e.length)b[c]='';else try{b[c]=decodeURIComponent(d)}catch(a){b[c]=d}return b}(a.split('&')),this.count=Object.keys(this.parameters).length,this.get=function(a){return a in this.parameters?this.parameters[a]:null},this.has=function(a){return a in this.parameters},this.set=function(a,b){this.parameters[a]=b,this.count=Object.keys(this.parameters).length},this.remove=function(a){!0===this.has(a)&&delete this.parameters[a],this.count=Object.keys(this.parameters).length},this.build=function(){var a=this,b=[];for(var c in a.parameters)!0===a.parameters.hasOwnProperty(c)&&b.push(c+'='+encodeURIComponent(a.parameters[c]));return b.join('&')},this.remove_usi_params=function(a){var b=this;for(var c in a=a||[],-1===a.indexOf('usi_')&&a.push('usi_'),b.parameters)if(!0===b.parameters.hasOwnProperty(c)){var d=!1;a.forEach(function(a){0===c.indexOf(a)&&(d=!0)}),d&&b.remove(c)}},this.remove_all=function(){var a=this;for(var b in a.parameters)!0===a.parameters.hasOwnProperty(b)&&a.remove(b)}});
"undefined"==typeof usi_date&&(usi_date={},usi_date.PSTOffsetMinutes=480,usi_date.localOffsetMinutes=(new Date).getTimezoneOffset(),usi_date.offsetDeltaMinutes=usi_date.localOffsetMinutes-usi_date.PSTOffsetMinutes,usi_date.toPST=function(e){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*usi_date.offsetDeltaMinutes*1e3)},usi_date.add_hours=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*t*60*1e3)},usi_date.add_minutes=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*t*1e3)},usi_date.add_seconds=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+1e3*t)},usi_date.get_week_number=function(e){var t={year:-1,weekNumber:-1};try{if(usi_date.is_date(e)){var a=new Date(Date.UTC(e.getFullYear(),e.getMonth(),e.getDate()));a.setUTCDate(a.getUTCDate()+4-(a.getUTCDay()||7));var s=new Date(Date.UTC(a.getUTCFullYear(),0,1)),i=Math.ceil(((a-s)/864e5+1)/7);t.year=a.getUTCFullYear(),t.weekNumber=i}}catch(e){}finally{return t}},usi_date.is_date=function(e){return null!=e&&"object"==typeof e&&e instanceof Date==!0&&!1===isNaN(e.getTime())},usi_date.is_date_within_range=function(e,t,a){if(void 0===e&&(e=usi_date.set_date()),!1===usi_date.is_date(e))return!1;var s=usi_date.string_to_date(t,!1),i=usi_date.string_to_date(a,!1),r=usi_date.toPST(e);return r>=s&&r<i},usi_date.is_after=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),a=new Date(e);return t.getTime()>a.getTime()}catch(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}return!1},usi_date.is_before=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),a=new Date(e);return t.getTime()<a.getTime()}catch(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}return!1},usi_date.is_between=function(e,t){return usi_date.check_format(e,t),usi_date.is_after(e)&&usi_date.is_before(t)},usi_date.check_format=function(e,t){(-1!=e.indexOf(" ")||t&&-1!=t.indexOf(" "))&&"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error("Incorrect format: Use YYYY-MM-DDThh:mm:ss")},usi_date.is_date_after=function(e,t){if(!1===usi_date.is_date(e))return!1;var a=usi_date.string_to_date(t,!1);return usi_date.toPST(e)>a},usi_date.is_date_before=function(e,t){if(!1===usi_date.is_date(e))return!1;var a=usi_date.string_to_date(t,!1);return usi_date.toPST(e)<a},usi_date.string_to_date=function(e,t){t=t||!1;var a=null,s=/^[0-2]?[0-9]\/[0-3]?[0-9]\/\d{4}(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e),i=/^(\d{4}\-[0-2]?[0-9]\-[0-3]?[0-9])(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e);if(2===(s||[]).length){if(a=new Date(e),""===(s[1]||"")&&!0===t){var r=new Date;a=usi_date.add_hours(a,r.getHours()),a=usi_date.add_minutes(a,r.getMinutes()),a=usi_date.add_seconds(a,r.getSeconds())}}else if(3===(i||[]).length){var o=i[1].split(/\-/g),u=o[1]+"/"+o[2]+"/"+o[0];return u+=i[2]||"",usi_date.string_to_date(u,t)}return a},usi_date.set_date=function(){var e=new Date,t=usi_commons.gup("usi_force_date");if(""!==t){t=decodeURIComponent(t);var a=usi_date.string_to_date(t,!0);null!=a?(e=a,usi_cookies.set("usi_force_date",t,usi_cookies.expire_time.hour),usi_commons.log("Date forced to: "+e)):usi_cookies.del("usi_force_date")}else e=null!=usi_cookies.get("usi_force_date")?usi_date.string_to_date(usi_cookies.get("usi_force_date"),!0):new Date;return e},usi_date.diff=function(e,t,a,s){null==s&&(s=1),""!=(a||"")&&(a=usi_date.get_units(a));var i=null;if(!0===usi_date.is_date(t)&&!0===usi_date.is_date(e))try{var r=Math.abs(t-e);switch(a){case"ms":i=r;break;case"seconds":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3),s);break;case"minutes":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60),s);break;case"hours":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"days":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s)}}catch(e){i=null}return i},usi_date.convert_units=function(e,t,a,s){var i=null,r=null;switch(usi_date.get_units(t)){case"days":i=1e6*e*1e3*60*60*24;break;case"hours":i=1e6*e*1e3*60*60;break;case"minutes":i=1e6*e*1e3*60;break;case"seconds":i=1e6*e*1e3;break;case"ms":i=1e6*e}switch(usi_date.get_units(a)){case"days":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s);break;case"hours":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"minutes":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60),s);break;case"seconds":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3),s);break;case"ms":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6),s)}return r},usi_date.get_units=function(e){var t="";switch(e.toLowerCase()){case"days":case"day":case"d":t="days";break;case"hours":case"hour":case"hrs":case"hr":case"h":t="hours";break;case"minutes":case"minute":case"mins":case"min":case"m":t="minutes";break;case"seconds":case"second":case"secs":case"sec":case"s":t="seconds";break;case"ms":case"milliseconds":case"millisecond":case"millis":case"milli":t="ms"}return t});

if (typeof usi_app === 'undefined') {
	try {
		usi_session_storage = true;
		usi_app = {};
		usi_app.ajax_listening = false;
		usi_cookies.max_cookies_count = 25;
		usi_app.main = function () {
			try {
				usi_app.recommendation_site_product = "35293";
				usi_app.coupon = usi_cookies.value_exists("usi_coupon_applied") ? "" : usi_commons.gup_or_get_cookie("usi_coupon", usi_cookies.expire_time.week, true);
				usi_app.promo_id = usi_commons.gup_or_get_cookie("usi_promo_id", usi_cookies.expire_time.day, true);
				usi_app.force_version = usi_commons.gup_or_get_cookie('usi_force_version');
				usi_app.force_date = usi_commons.gup_or_get_cookie('usi_force_date');
				usi_app.current_date = usi_app.force_date || usi_date.set_date();

				usi_app.is_enabled = usi_commons.gup_or_get_cookie("usi_enable", usi_cookies.expire_time.day, true) != "";
				usi_app.is_suppressed = usi_app.is_confirmation_page || document.getElementById("mark-current-store") == null;
				usi_app.is_choose_capacity = document.querySelector('[data-attr="Capacity"]') != null;

				if (usi_cookies.value_exists("usi_enable")) {
					usi_cookies.set("usi_enable", 1, usi_cookies.expire_time.day);
					usi_commons.gup_or_get_cookie("usi_force_date", usi_cookies.expire_time.day, true);
				}

				if (usi_commons.gup("irclickid") != "" && (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null)) {
					usi_cookies.del("usi_clicked_1");
					var date_now = Date.now().toString();
					var cookie_value = date_now + "|-1|" + date_now + "|" + usi_commons.gup("irclickid") + "|";
					usi_cookies.create_nonencoded_cookie("IR_" + usi_commons.gup("utm_campaign"), cookie_value, 30 * 24 * 60 * 60, true);
				}

				// Collect product page data
				usi_app.product_page_data = {};
				if (usi_app.is_product_page) {
					usi_app.product_page_data = usi_app.send_product_data();
				}

				// Rebuild cart
				if (!usi_cookies.value_exists("usi_suppress_cr") && usi_app.is_cart_page && usi_commons.gup("usi_rebuild") != "" && document.querySelector(".hint-empty") != null) {
					usi_data.get_session_data(usi_commons.gup("usi_rebuild"), usi_app.rebuild);
					return;
				}

				// Check suppressions
				if (usi_app.is_suppressed) return usi_commons.log("[ main ] Company is suppressed");

				// Set dynamic promos
				usi_app.promos = {
					over: 0,
					offer: ""
				}
				if (usi_app.promo_id) {
					usi_app.promos = {
						over: usi_app.promo_id.split("_")[0],
						offer: usi_app.promo_id.split("_")[1]
					}
				}
				usi_app.reminder = {
					en: {
						over: "Your discount will be applied at checkout",
						under: "Add {{togo}} to qualify for your {{discount}} off discount"
					},
					fr: {
						over: "Votre rabais sera appliqu\u00E9 lors du passage de la commande",
						under: "Ajouter {{togo}} pour \u00EAtre admissible \u00E0 votre {{discount}} de remise"
					},
					it: {
						over: "Lo sconto verr\u00E0 applicato al momento del pagamento",
						under: "Aggiungi {{togo}} a qualificarsi per la vostra {{discount}} di sconto"
					},
					de: {
						over: "Ihr Rabatt wird an der Kasse aktiviert werden",
						under: "{{togo}} f\u00FCr {{discount}} weg vom Rabatt zu qualifizieren"
					},
					nl: {
						over: "Uw korting zal worden toegepast bij de kassa",
						under: "Voeg {{togo}} in aanmerking te komen voor de {{discount}} korting op korting"
					},
					es: {
						over: "Su descuento ser\u00E1 aplicado al momento de pagar",
						under: "A\u00F1adir {{togo}} para calificar para el {{discount}} de descuento"
					}
				}

				// Save cart data
				if (usi_app.is_cart_page) {
					usi_app.save_cart();
				} else if (usi_app.is_checkout_page && document.querySelector('.order-confirm-container .price-subtotal .price-value') != null) {
					if (document.querySelector('.order-confirm-container .price-total .price-value').textContent != null) {
						var subtotal = usi_app.clean_subtotal(document.querySelector('.order-confirm-container .price-total .price-value').textContent).toFixed(2);
						if (subtotal) usi_cookies.set("usi_subtotal", subtotal, usi_cookies.expire_time.week);
					}
				} else {
					usi_app.start_cart_monitor();
				}

				// Listen for cart posts
				if (!usi_app.ajax_listening) {
					usi_app.ajax_listening = true;
					usi_app.setup_listener("/xman/cart/batch-add", usi_app.handle_ajax_response);
				}

				// Monitor for client email input
				usi_app.poll_for_modal();

				// Load campaigns
				usi_app.load();
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load = function () {
			try { // Clean up previous solutions
				usi_commons.log("[USI] usi_app.load()")
				if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') {
					usi_js.cleanup();
				}

				// Set campaign vars
				var active_cart = usi_app.cart && usi_app.cart.items && usi_app.cart.items.length > 0 && usi_app.cart.items[0].pid;
				var subtotal = usi_cookies.get('usi_subtotal') || '0';
				subtotal = usi_app.clean_subtotal(subtotal);
				usi_commons.log('[ load ] subtotal:', subtotal);

				// Load boost bars for tiered tt
				if (usi_app.coupon != "") {
					return usi_app.set_boostbar(subtotal);
				}

				// Custom click suppressions
				if (usi_cookies.value_exists("usi_custom_click_suppress")) return;

				// Sets usi_app.general_promo, usi_app.one_off_promo
				usi_app.find_eligible_promos();

				// TT - Cart Page RTR
				if (usi_app.is_cart_page && active_cart) {
					var nomatch = "";
					if (usi_cookies.value_exists("usi_prod_name_1") && usi_cookies.value_exists("usi_prod_pid_1")) {
						var name = decodeURIComponent(usi_cookies.get("usi_prod_name_1"));
						name = name.substring(0, name.indexOf('|'));
						var pid = usi_cookies.get("usi_prod_pid_1").replace('-', ' ');
						nomatch = name + "," + pid + ",";
						nomatch += "bundle,";
					}
					usi_app.load_product_data({
						siteID: usi_app.recommendation_site_product,
						pid: usi_app.cart.items[0].pid + "_" + usi_app.locale,
						match: "_" + usi_app.locale,
						nomatch: "OUTOFSTOCK,5431100216,5011101492," + nomatch,
						less_expensive: true,
						force_exact: true,
						rows: 100,
						callback: function () {
							setTimeout(function () {
								if (false && usi_app.general_promo.length != undefined && usi_app.general_promo.length > 0) {
									usi_commons.log(" Load Cart Recommendation  ")
									usi_commons.load_view("4iBOTJ0frFV3X79uYGMSMK8", "38442", usi_commons.device + "_" + usi_app.locale);
								} else {
									usi_commons.log(" Load Cart Recommendation [no-incentive) | locale: ", usi_app.locale, "] ")
									usi_commons.load_view("mUgmLIPRq7UDk5ArTcrGlKX", "41398", usi_commons.device + "_" + usi_app.locale);
								}
							}, 800);

						}
					});
				}

				// TT - Product Page Abandon
				if (usi_app.one_off_promo != null) {
					
					usi_app.campaign_data = usi_app.one_off_promo;
					usi_commons.log(" Load Precise Promotion | One Off Promo  ")
					usi_commons.load_view("GCtfTt6sm5q2rpIc0P2DrEb", "42030", usi_commons.device + "_" + usi_app.locale);
				} else if (usi_app.is_product_page && usi_app.product_page_data && (usi_app.product_original_price != null && usi_app.product_current_price != null)) {
					usi_commons.log(" Load Precise Promotion | Product Specific ")
					usi_commons.load_view("at8Kvn1AKO64GG99TZfy22z", "39888", usi_commons.device + "_" + usi_app.locale);
				} else if ((usi_app.is_product_page && usi_app.product_page_data && usi_app.campaign_data != null && usi_app.is_prod_specific_loaded)) {
					setTimeout(function () {
						usi_commons.log(" Load Precise Promotion | Product Specific [Redesign] ")
						usi_commons.load_view("2y4kummVNBwsDAgFPllu3lb", "38438", usi_commons.device + "_" + usi_app.locale);
					}, 800);
				} else if ((usi_app.is_product_page || usi_app.is_checkout_page) && usi_app.general_promo.length > 0 && usi_app.campaign_data != null) {
					if (usi_app.campaign_data.threshold != null && usi_app.campaign_data.incentive != null) {
						setTimeout(function () {
							if (!usi_app.is_prod_specific_loaded && usi_app.is_prod_specific_loaded != null) {
								usi_app.campaign_data = usi_app.general_promo[0];
							}
							usi_commons.log(" Load Precise Promotion | Product Abandon Generic  ")
							usi_commons.load_view("JrUDHfXTlNhl9DOfHckg2C6", "38440", usi_commons.device + "_" + usi_app.locale);
						}, 800);
					}
				} else if (!usi_app.is_cart_page && subtotal > 0 && usi_cookies.value_exists("usi_prod_name_1")) {
					//  Inboxed Incentive | Cart Preserver
					if (usi_app.campaign_data) {
						if (usi_app.is_enabled && usi_app.campaign_data.threshold != null && usi_app.campaign_data.incentive != null) {
							setTimeout(function () {
								usi_commons.log(" Load Inboxed Incentive | Cart Preserver  ")
								usi_commons.load_view("IJdHqPx641gvVHASrrgqVzK", "38444", usi_commons.device + "_" + usi_app.locale);
							}, 800);
						}
					} else {
						setTimeout(function () {
							usi_commons.log(" Load Inboxed Incentive | Cart Preserver [non-incentive] ")
							usi_commons.load_view("l6VR5u1GM1XUvWrtR3tBBOa", "41364", usi_commons.device + "_" + usi_app.locale);
						}, 800);
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.set_boostbar = function(subtotal){
			var apply_coupon = false;
			var language = usi_app.get_language();
			if (usi_cookies.value_exists("usi_promo_id")) {
				var boost_txt = "";
				if (usi_app.promo_id != "") {
					var over = usi_dom.string_to_decimal(usi_app.promo_id.split("_")[0]);
					var offer = usi_app.promo_id.split("_")[1];
					var togo = "";
					if (subtotal >= over) {
						apply_coupon = true;
						boost_txt = usi_app.reminder[language].over;
					} else {
						togo = usi_app.format_price((over - subtotal).toFixed(2));
						var discount = offer.indexOf("%") != -1 ? offer : usi_app.format_price(offer);
						boost_txt = usi_app.reminder[language].under.replace("{{togo}}", togo).replace("{{discount}}", discount);
					}
					if (boost_txt != "" && !isNaN(togo)) {
						setTimeout(function () {
							usi_app.boostbar.load(boost_txt);
						}, 1000);
					}
				}
			} else {
				apply_coupon = true;
			}
			// Apply coupon
			if (apply_coupon && !usi_app.coupon_interval && usi_app.is_checkout_page && usi_app.coupon != "") {
				usi_app.monitor_coupon_apply();
			}
		}
		usi_app.find_eligible_promos = function(){
			var specific_promo = {};
			var general_promo = {};
			var one_off_promo = [];
			//var promo_date_version = "";
			if (usi_app.is_product_page) {
				usi_app.get_product_page_sales_info();
			}

			var size_container = document.querySelectorAll('.product-station__purchase .row')[1];
			if (size_container != null) {
				if (!size_container.textContent.includes("GB RAM")) {
					size_container = document.querySelectorAll('.product-station__purchase .row')[2];
				}
			}

			general_promo = usi_app.promos_general.filter(usi_app.is_eligible_promo);
			one_off_promo = usi_app.promos_one_off.filter(usi_app.is_eligible_promo);
			usi_app.one_off_test = one_off_promo;

			if (one_off_promo.length > 1) {
				// if length is greater than 2, then maybe we have two different capacity sizes
				if (size_container != null) {
					if (size_container.querySelector('.active').textContent.match("128") != null) {
						one_off_promo = one_off_promo[0];
					} else if (size_container.querySelector('.active').textContent.match("256") != null) {
						one_off_promo = one_off_promo[1];
					}
				} else {
					// else  that means there is a promo spanning the entire month conflicting with a a promo that is a smaller specific datespan
					one_off_promo = one_off_promo[1];
				}
			} else {
				one_off_promo = one_off_promo[0];
			}
			usi_app.general_promo = general_promo;
			usi_app.one_off_promo = one_off_promo;

			if (general_promo.length > 0 && (usi_app.is_enabled || !general_promo[0].testing)) {
				usi_app.campaign_data = general_promo[0];
			}

			// if product page has a selection between different models; add a listener to update campaign info accordingly
			if (size_container != null) {
				usi_app.add_size_listeners(size_container, specific_promo);
			}
		}
		usi_app.add_size_listeners = function(size_container, specific_promo){
			if (usi_app.choose_capacity_data != null) {
				usi_app.campaign_data = usi_app.choose_capacity_data;
			}

			var option_one = size_container.querySelectorAll('.option-group .option-item')[0];
			var option_two = size_container.querySelectorAll('.option-group .option-item')[1];
			var option_three = size_container.querySelectorAll('.option-group .option-item')[2];

			if (option_one != null) {
				option_one.addEventListener("click", function () {
					if (option_one.querySelector('.font-descriptions').textContent.match("128") != null && specific_promo[0] != null) {
						usi_app.choose_capacity_data = specific_promo[0];
						usi_app.is_prod_specific_loaded = true;
					} else if (option_one.querySelector('.font-descriptions').textContent.match("256") != null) {
						if (specific_promo[1] != null) {
							if (specific_promo[1].coupon != null && specific_promo[1].incentive != "") {
								usi_app.choose_capacity_data = specific_promo[1];
								usi_app.is_prod_specific_loaded = true;
							}
						}
					} else {
						usi_app.choose_capacity_data = null;
						usi_app.is_prod_specific_loaded = false;
					}
					usi_app.load();
				});
			}

			if (option_two != null) {
				option_two.addEventListener("click", function () {
					if (option_two.querySelector('.font-descriptions').textContent.match("128") != null && specific_promo[0]) {
						usi_app.choose_capacity_data = specific_promo[0];
						usi_app.is_prod_specific_loaded = true;
					} else if (option_two.querySelector('.font-descriptions').textContent.match("256") != null) {
						if (specific_promo[1] != null) {
							if (specific_promo[1].headline != null && specific_promo[1].incentive != "") {
								usi_app.choose_capacity_data = specific_promo[1];
								usi_app.is_prod_specific_loaded = true;
							}
						} else {
							usi_app.choose_capacity_data = specific_promo[0];
							usi_app.is_prod_specific_loaded = true;
						}

					} else {
						usi_app.choose_capacity_data = null;
						usi_app.is_prod_specific_loaded = false;
					}
					usi_app.load();
				});
			}

			if (option_three != null) {
				option_three.addEventListener("click", function () {
					if (option_three.querySelector('.font-descriptions').textContent.match("128") != null && specific_promo[0] != null) {
						usi_app.choose_capacity_data = specific_promo[0];
						usi_app.is_prod_specific_loaded = true;
					} else if (option_three.querySelector('.font-descriptions').textContent.match("256") != null && specific_promo[1].coupon != null && specific_promo[1].incentive != "") {
						usi_app.choose_capacity_data = specific_promo[1];
						usi_app.is_prod_specific_loaded = true;
					} else {
						usi_app.choose_capacity_data = null;
						usi_app.is_prod_specific_loaded = false;
					}
					usi_app.load();
				});
			}
		}

		usi_app.is_eligible_promo = function (promo) {
			usi_commons.log("usi_app.is_eligible_promo()");
			try {
				var pathname = location.pathname;
				if (location.pathname.match('/product/') != null) {
					var split = pathname.split('/');
					pathname = "/" + split[split.length - 1];
				} else {
					var split = pathname.split('/');
					pathname = "/" + split[split.length - 1];
				}
				var valid_url = !promo.url ? true : pathname.match(new RegExp(promo.url + "$", "i")) != null;
				var valid_price = true;
				var valid_date = usi_date.is_after(promo.start + "T00:00-08:00") && usi_date.is_before(promo.end + "T23:59:59-08:00");
				var price = 0;
				if (usi_app.product_page_data && usi_app.product_page_data.price) price = usi_app.product_page_data.price;
				if (usi_cookies.value_exists("usi_subtotal")) price = usi_dom.string_to_decimal(decodeURIComponent(usi_cookies.get("usi_subtotal")));
				if (promo.subtotal) {
					if (promo.subtotal.indexOf("+") != -1) {
						valid_price = Number(price) > promo.subtotal.split("+")[0];
					} else if (promo.subtotal.indexOf("-") != -1) {
						valid_price = Number(price) > promo.subtotal.split("-")[0] &&
							Number(price) < promo.subtotal.split("-")[1];
					}
				}

				// Check threshold value vs subtotal
				if(promo.threshold && price) {
					if(Number(price) < promo.threshold) {
						valid_price = false;
					}
				}

				return (promo.locale.toUpperCase() == usi_app.locale.toUpperCase()) && valid_url && valid_price && valid_date;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.clean_subtotal = function (subtotal) {
			try {
				subtotal = decodeURIComponent(subtotal);
				if (subtotal.indexOf('$CA') !== -1 || subtotal.indexOf('\u20AC') !== -1) subtotal = subtotal.replace(',', '.');
				return Number(usi_dom.string_to_decimal(subtotal));
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.get_language = function () {
			var language = "en";
			if (usi_app.locale.indexOf("fr") != -1) {
				language = "fr";
			} else if (usi_app.locale.indexOf("it") != -1) {
				language = "it";
			} else if (usi_app.locale.indexOf("es") != -1) {
				language = "es";
			} else if (usi_app.locale.indexOf("de") != -1) {
				language = "de";
			} else if (usi_app.locale.indexOf("nl") != -1) {
				language = "nl";
			}
			return language;
		};

		usi_app.format_price = function (price) {
			try {
				var format = "XX,00 \u20AC"; // es, de, be_fr, fr
				if (usi_app.locale == "uk") {
					format = "\u00A3XX.00";
				} else if (usi_app.locale == "us") {
					format = "XX.00";
				} else if (usi_app.locale == "ca_en") {
					format = "CA$XX.00";
				} else if (usi_app.locale == "ca_fr") {
					format = "XX,00 $CA";
				} else if (usi_app.locale == "it" || usi_app.locale == "be_nl") {
					format = "\u20AC XX,00";
				}
				if (format.indexOf(",") != -1) {
					return format.replace("XX,00", String(price).replace(".", ","));
				}
				return format.replace("XX.00", price);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.recs_over = function (togo) {
			try {
				var recs = []
				for (var i = 1; i < 20; i++) {
					if (usi_app.product_rec["product" + i]) {
						recs.push(usi_app.product_rec["product" + i])
					}
				}
				var filtered = recs.sort(function (a, b) {
					return Number(a.price) > Number(b.price) ? 1 : -1;
				}).filter(function (a) {
					return Number(a.price) > togo;
				});
				for (var i = 1; i <= 4; i++) {
					if (filtered[i]) {
						usi_app.product_rec["product" + i] = filtered[i];
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.filter_recs = function (match) {
			try { //"_" + usi_app.locale
				var recs = []
				for (var i = 1; i < 50; i++) {
					if (usi_app.product_rec["product" + i] && usi_app.product_rec["product" + i].pid.indexOf("_" + usi_app.locale) != -1 && usi_app.product_rec["product" + i].url.indexOf(match) != -1) {
						recs.push(usi_app.product_rec["product" + i])
					}
				}
				if (recs.length > 4) usi_app.product_rec = {};
				for (var i = 1; i <= recs.length; i++) {
					usi_app.product_rec["product" + i] = recs[i];
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.get_product_page_sales_info = function () {
			try {
				if (document.querySelector(".percentage-off .tag-text") != null) {
					if (document.querySelector(".price-container .price") != null) {
						usi_app.product_current_price = usi_dom.string_to_decimal(document.querySelector(".price-container .price").textContent);
					}
					if (document.querySelector(".price-container .original-price") != null) {
						usi_app.product_original_price = usi_dom.string_to_decimal(document.querySelector(".price-container .original-price").textContent);
					}
					if (document.querySelector(".percentage-off .tag-text") != null) {
						usi_app.product_percentage_off = usi_dom.string_to_decimal(document.querySelector(".percentage-off .tag-text").textContent);
					}
				} else if (document.querySelector('.discounted-price') != null) {
					if (document.querySelector('.price-text-container .mrp-design') != null) {
						usi_app.product_original_price = usi_dom.string_to_decimal(document.querySelector(".price-text-container .mrp-design").textContent);
					}
					if (document.querySelector('.price-text-container .text-gray') != null) {
						usi_app.product_original_price = usi_dom.string_to_decimal(document.querySelector(".price-text-container .text-gray").textContent);
					}
					if (document.querySelector('.price-text-container .discounted-price') != null) {
						usi_app.product_current_price = usi_dom.string_to_decimal(document.querySelector(".price-text-container .discounted-price").textContent);
					}
					if (usi_app.product_original_price != null && usi_app.product_current_price != null) {
						usi_app.product_percentage_off = 100 - Math.round(((usi_app.product_current_price / usi_app.product_original_price) * 100));
					}
				}

				if (document.querySelector('.product-share .product-name') != null) {
					usi_app.product_name = document.querySelector('.product-share .product-name').textContent.trim();
				} else if (document.querySelector('.right-container .js-name') != null) {
					usi_app.product_name = document.querySelector('.right-container .js-name').textContent.trim();
				}

				if (usi_app.scrape_image()) {
					usi_app.product_image = usi_app.scrape_image();
				} else if (document.querySelector('.gallery-top .swiper-slide-active div') != null) {
					var image_url = document.querySelector('.gallery-top .swiper-slide-active div').style.backgroundImage;
					usi_app.product_image = image_url.slice(4, -1).replace(/["']/g, "");
				} else if (document.querySelector('.image-container') != null) {
					usi_app.product_image = document.querySelector('.image-container img').src;
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.is_locale_europe = function () {
			try {
				return !(usi_app.locale == "us" || usi_app.locale == "ca_en" || usi_app.locale == "ca_fr");
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.send_cart_data = function () {
			try {
				usi_js.send_data('usi_cart', JSON.stringify(usi_cookies.get_json("usi_cart_data") || {}));
				usi_js.send_data('utf8_subtotal', encodeURIComponent(usi_app.format_price(usi_cookies.get("usi_subtotal"))));
				var item_num, usi_product, prop;
				for (item_num = 1; item_num <= 3; item_num++) {
					usi_product = {
						image: usi_cookies.get("usi_prod_image_" + item_num),
						name: usi_cookies.get("usi_prod_name_" + item_num),
						price: usi_app.format_price(usi_cookies.get("usi_prod_price_" + item_num))
					};
					for (prop in usi_product) {
						if (usi_product.hasOwnProperty(prop) && usi_product[prop] != null) {
							if (prop != "image") {
								usi_js.send_data('utf8_prod_' + prop + '_' + item_num, encodeURIComponent((usi_product[prop])));
							} else {
								usi_js.send_data('usi_prod_' + prop + '_' + item_num, decodeURIComponent(usi_product[prop]));
							}
						}
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.link_injection = function (destination) {
			try {
				var usi_dynamic_div = document.createElement("div");
				usi_dynamic_div.innerHTML = "<iframe style='width: 1px; height: 1px;' src='" + destination + "'></iframe>";
				document.getElementsByTagName('body')[0].appendChild(usi_dynamic_div);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.poll_for_modal = function () {
			try {
				var email_input = document.querySelector('.subscribe-input-email.field-pack input');
				if (email_input == null) return setTimeout(usi_app.poll_for_modal, 1000);
				usi_dom.attach_event("input", function () {
					usi_commons.log("[ poll_for_modal ] Suppressed");
					usi_cookies.set("usi_suppress_oneplus", "1", usi_cookies.expire_time.week);
					if (typeof usi_js != "undefined") {
						usi_js.suppress();
					}
				}, email_input);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.save_cart = function () {
			try {
				usi_commons.log("usi_app.save_cart()");
				var prod_prefix = "usi_prod_";
				usi_cookies.flush(prod_prefix);
				usi_app.cart = {
					items: usi_app.scrape_cart(),
					subtotal: usi_app.scrape_subtotal()
				}

				if (typeof usi_app.cart.items != "undefined") {
					usi_cookies.set("usi_cart_count", usi_app.cart.items.length);
					usi_app.cart.items.forEach(function (product, index) {
						var prop;
						if (index >= 3) return;
						for (prop in product) {
							if (product.hasOwnProperty(prop)) {
								usi_cookies.set(prod_prefix + prop + "_" + (index + 1), encodeURIComponent(product[prop]), usi_cookies.expire_time.week);
							}
						}
					});
				}
				usi_commons.log('[ save_cart ] items:', usi_app.cart.items);

				if (document.querySelector('.total-price') != null) {
					var subtotal = document.querySelector('.total-price').textContent;

					if (subtotal != null) {
						var subtotal_value = usi_app.clean_subtotal(subtotal);
						usi_cookies.set("usi_subtotal", subtotal_value.toFixed(2), usi_cookies.expire_time.week);
					}
					usi_commons.log('[ save_cart ] subtotal:', usi_app.cart.subtotal);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.get_pids = function () {
			try {
				var pid_array = [];
				var item_num, usi_product, prop;
				for (item_num = 1; item_num <= 3; item_num++) {
					usi_product = {
						data: usi_cookies.get("usi_prod_data_" + item_num)
					};
					for (prop in usi_product) {
						if (usi_product.hasOwnProperty(prop) && usi_product[prop] != null) {
							var pid = decodeURIComponent(usi_product[prop]);
							pid_array.push(pid);
						}
					}
				}
				return pid_array;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_subtotal = function () {
			try {
				var subtotal = document.querySelector(".cart-total, .cart-info .total-price .value");
				if (subtotal != null) {
					subtotal = subtotal.textContent.trim();
					return usi_app.clean_subtotal(subtotal);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_cart = function () {
			try {
				var cart_rows = usi_dom.get_elements('.product-list');
				var items = [], product;
				cart_rows.forEach(function (container) {
					product = {};
					if (container.querySelector("a")) {
						product.link = container.querySelector("a").href;
						product.pid = product.link.substring(product.link.lastIndexOf("/") + 1);
					}
					if (container.querySelector("img")) {
						product.image = container.querySelector("img").src;
					}
					if (container.querySelector(".product-main-name")) {
						product.name = container.querySelector(".product-main-name").textContent.trim();
					}
					if (container.querySelector(".main-price .cart-price-text")) {
						product.price = usi_app.clean_subtotal(container.querySelector(".main-price .cart-price-text").textContent.trim()).toFixed(2);
					}
					items.push(product);
				});
				return items;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.setup_listener = function (url, callback) {
			try {
				usi_app.ajaxListener = new usi_ajax.listener();
				usi_app.ajaxListener.register('POST', url, callback);
				usi_app.ajaxListener.listen();
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.start_cart_monitor = function(){
			try {
				usi_commons.log("usi_app.start_cart_monitor()");
				var monitor_cart = function() {
					var total = usi_app.scrape_subtotal();
					// Only update if cart subtotal changes
					if (total && Number(total) > 0 && usi_app.total != total) {
						usi_app.total = total;
						usi_cookies.set('usi_subtotal', total, usi_cookies.expire_time.week)

						// Check if data has changed and load campaigns
						usi_app.load();
					}
					setTimeout(monitor_cart, 1000);
				};
				monitor_cart();
				if (!usi_app.cart_timeout) {
					usi_app.cart_timeout = setTimeout(monitor_cart, 1000);
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.handle_ajax_response = function (err, response) {
			try {
				if (response) {
					// Record params for cart rebuilder
					if (response.requestObj && response.requestObj.params && usi_app.is_product_page) usi_app.record_cart_rebuilder_params(response.requestObj.params);
					setTimeout(function () {
						usi_app.save_minicart();
					}, 1000);
				} else {
					usi_commons.report_error(err);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.save_minicart = function () {
			try {
				usi_commons.log('usi_app.save_minicart()');
				var prod_prefix = "usi_prod_";
				usi_cookies.flush(prod_prefix);

				var scrape_cart = function () {
					try {
						var cart_rows = usi_dom.get_elements('.minicart-container .products-link');
						var items = [], product;
						cart_rows.forEach(function (container) {
							product = {};
							product.image = container.querySelector(".td-image img").src;
							if (container.querySelector(".item-name") != null) {
								product.name = container.querySelector(".item-name").textContent.trim();
							}
							product.price = usi_dom.string_to_decimal(container.querySelector(".now-price").textContent.trim()).toFixed(2);

							items.push(product);
						});
						return items;
					} catch (err) {
						usi_commons.report_error(err);
					}
				};

				var subtotal = 0, subtotal_el = document.querySelector(".total-price .value");
				if (subtotal_el && subtotal_el.textContent) subtotal = usi_app.clean_subtotal(subtotal_el.textContent);

				usi_app.cart = {
					items: scrape_cart(),
					subtotal: subtotal
				};

				if (typeof usi_app.cart.items != "undefined") {
					usi_app.cart.items.forEach(function (product, index) {
						var prop;
						if (index >= 3) return;
						for (prop in product) {
							if (product.hasOwnProperty(prop)) {
								usi_cookies.set(prod_prefix + prop + "_" + (index + 1), encodeURIComponent(product[prop]), usi_cookies.expire_time.week);
							}
						}
					});
				}
				usi_commons.log('[ save_minicart ] items:', usi_app.cart.items);
				var subtotal = document.querySelector('.total-price');

				if (subtotal != null) {
					var subtotal_number = usi_app.clean_subtotal(document.querySelector('.total-price').textContent).toFixed(2);
					usi_cookies.set("usi_subtotal", subtotal_number, usi_cookies.expire_time.week);
				}
				usi_commons.log('[ save_minicart ] subtotal:', usi_app.cart.subtotal);

				usi_app.load();
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.monitor_coupon_apply = function () {
			try { // Site requires a shipping address first before it allows coupon application
				var monitor_address = function () {
					if (document.querySelector('.address-detail') != null && usi_app.coupon != "") {
						clearInterval(usi_app.coupon_interval);
						usi_app.apply_coupon();
					}
				};
				monitor_address();
				if (!usi_app.coupon_interval) {
					usi_app.coupon_interval = setInterval(monitor_address, 1000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.apply_coupon = function () {
			try {
				var coupon_input = usi_dom.get_first_element("#input-coupon-code-visitor");
				var coupon_button = usi_dom.get_first_element("button.check-code-btn");
				if (coupon_input !== null && coupon_button !== null) {
					// Register something
					var customEvent = new Event('input', {bubbles: true});
					var lastValue = coupon_input.value;
					customEvent.simulated = true;
					coupon_input.value = usi_app.coupon;
					coupon_input.defaultValue = usi_app.coupon;
					var tracker = coupon_input['_valueTracker'];
					if (tracker) {
						tracker.setValue(lastValue);
					}
					usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?oneplus_coupon=" + usi_app.coupon);
					usi_cookies.set("usi_coupon_applied", usi_app.coupon, usi_cookies.expire_time.week, true);
					usi_app.coupon = "";
					usi_cookies.del("usi_coupon");
					coupon_input.dispatchEvent(customEvent);
					coupon_button.click();
					setTimeout(usi_app.post_apply_coupon, 2000);
					usi_commons.log("[ apply_coupon ] Coupon applied");
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.post_apply_coupon = function () {
			var error_element = usi_dom.get_first_element(".validation-message.ng-scope");
			var error_message_exists = error_element != null && error_element.textContent.trim() != "" && error_element.textContent.indexOf("Sorry") != -1;
			if (error_message_exists) {
				usi_commons.report_error("[ post_apply_coupon ] Coupon error message seen");
			} else {
				usi_commons.log_success("[ post_apply_coupon ] Coupon application was successful");
			}
		};

		usi_app.send_product_data = function () {
			try {
				var product = usi_app.scrape_product_page();
				usi_commons.log('[ send_product_data ] product:', product);
				if (product && product.pid && product.name && product.price && product.image) {
					usi_commons.send_prod_rec(usi_app.recommendation_site_product, product, !product.in_stock);
				}
				return product;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_sku = function () {
			try {
				if (usi_app.data_stats != null && typeof (usi_app.data_stats.phone) !== "undefined" && typeof (usi_app.data_stats.phone.sku) !== "undefined") {
					if (usi_app.data_stats.phone.sku != "") {
						return usi_app.data_stats.phone.sku;
					}
				}
				if (typeof (ecommerce) != "undefined" && typeof (ecommerce.detail) != "undefined" && typeof (ecommerce.detail.products) != "undefined") {
					if (typeof (ecommerce.detail.products[0]) != "undefined") {
						for (var i = 0; i < ecommerce.detail.products.length; i++) {
							if (ecommerce.detail.products[i].id != null) {
								return ecommerce.detail.products[i].id;
							}
						}
					}
					if (ecommerce.detail.products.id != null) {
						return ecommerce.detail.products.id;
					}
				}
				if (document.querySelector(".sku-step input") != null) {
					return document.querySelector(".sku-step input").getAttribute("name");
				}
				if (document.querySelector(".simple-step input") != null) {
					return document.querySelector(".simple-step input").getAttribute("name");
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.scrape_image = function () {
			try {
				if (usi_app.data_stats != null && typeof (usi_app.data_stats.phone) !== "undefined" && typeof (usi_app.data_stats.phone.imageUrl) !== "undefined") {
					if (usi_app.data_stats.phone.imageUrl != "") {
						return usi_app.data_stats.phone.imageUrl;
					}
				}
				var img_el = document.querySelector('.gallery-thumbnail-placeholder img, .swiper-lazy, .image-container img');
				if (img_el) {
					return img_el.src;
				}

				if (document.querySelector('.phone-preview .swiper-slide-active img') != null) {
					return document.querySelector('.phone-preview .swiper-slide-active img').src;
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.scrape_name = function () {
			try {
				if (usi_app.data_stats != null && typeof (usi_app.data_stats.phone) !== "undefined" && typeof (usi_app.data_stats.phone.name) !== "undefined") {
					if (usi_app.data_stats.phone.name != "") {
						return usi_app.data_stats.phone.name;
					}
				}
				if (typeof (window.ecommerce) != "undefined" && typeof (window.ecommerce.detail) != "undefined" && typeof (window.ecommerce.detail.products) != "undefined") {
					if (typeof (window.ecommerce.detail.products[0]) != "undefined") {
						for (var i = 0; i < window.ecommerce.detail.products.length; i++) {
							if (window.ecommerce.detail.products[i].name != null) {
								return window.ecommerce.detail.products[i].name;
							}
						}
					}
					if (window.ecommerce.detail.products.name != null) {
						return window.ecommerce.detail.products.name;
					}
				}
				if (document.querySelector(".sku-step input") != null && document.querySelector(".sku-step input").getAttribute("data-name") != null) {
					return document.querySelector(".sku-step input").getAttribute("data-name");
				}
				if (document.getElementsByClassName("js-name").length > 0) {
					return document.getElementsByClassName("js-name")[0].innerText;
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.scrape_price = function () {
			try {
				if (usi_app.data_stats != null && typeof (usi_app.data_stats.subtotal) !== "undefined") {
					if (usi_app.data_stats.subtotal != "") {
						return usi_app.data_stats.subtotal;
					}
				}
				if (typeof (ecommerce) != "undefined" && typeof (ecommerce.detail) != "undefined" && typeof (ecommerce.detail.products) != "undefined") {
					if (typeof (ecommerce.detail.products[0]) != "undefined") {
						for (var i = 0; i < ecommerce.detail.products.length; i++) {
							if (ecommerce.detail.products[i].price != null) {
								return ecommerce.detail.products[i].price;
							}
						}
					}
					if (ecommerce.detail.products.price != null) {
						return ecommerce.detail.products.price;
					}
				}
				if (document.querySelector(".sku-step input") != null) {
					return document.querySelector(".sku-step input").getAttribute("data-price");
				}
				if (document.getElementsByClassName("discounted-price").length == 1) {
					return document.getElementsByClassName("discounted-price")[0].innerText.replace(/[^0-9.]+/g, "");
				}
				if (document.querySelector('.price-container .price') != null) {
					return usi_dom.string_to_decimal(document.querySelector('.price-container .price').textContent);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.scrape_msrp = function () {
			try {
				if (usi_app.data_stats != null && typeof (usi_app.data_stats.subtotalOrigin) !== "undefined") {
					if (usi_app.data_stats.subtotalOrigin != "") {
						return usi_app.data_stats.subtotalOrigin + "";
					}
				}
				if (document.querySelector("del.text-gray") != null) {
					return usi_app.standardize_currency(document.querySelector("del.text-gray").innerText.replace(/[^0-9.,]+/g, ""));
				}
				if (document.getElementsByClassName("mrp-design").length == 1) {
					return usi_app.standardize_currency(document.getElementsByClassName("mrp-design")[0].innerText.replace(/[^0-9.,]+/g, ""));
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.scrape_stock = function () {
			try {
				if (document.querySelector(".sku-step input") != null) {
					if (document.querySelector(".sku-step input").getAttribute("data-stock") == "1") return "INSTOCK";
				}
				if (document.getElementById("checkout-buy") != null && !document.getElementById("checkout-buy").disabled) {
					return "INSTOCK";
				}
				if (document.getElementsByClassName("btn-add-to-cart").length == 1 && !document.getElementsByClassName("btn-add-to-cart")[0].disabled) {
					return "INSTOCK";
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return "OUTOFSTOCK";
		};

		usi_app.standardize_currency = function (currency_str) {
			var usi_final;
			currency_str = currency_str.replace(/[^0-9.,]+/g, "");
			if (currency_str.indexOf(",") != -1 && (currency_str.split(",")[1].length == 2 || currency_str.split(",")[1].length == 1)) {
				//This is a 199,99 format
				usi_final = currency_str.split(",")[0].replace(/[^0-9]+/g, "") + "." + currency_str.split(",")[1];
			} else {
				usi_final = currency_str.replace(/[^0-9.]+/g, "");
			}
			if (isNaN(Number(usi_final)) || Number(usi_final) > 80000) return "";
			return (Number(usi_final).toFixed(2)) + "";
		};

		usi_app.scrape_product_page = function () {
			try {
				var product = {};
				usi_app.data_stats = null;
				if (document.getElementById("data-stats") != null) {
					try {
						usi_app.data_stats = JSON.parse(document.getElementById("data-stats").innerText);
					} catch (err) {
						usi_commons.report_error(err);
					}
				}
				product.link = location.protocol + '//' + location.host + location.pathname;
				product.name = usi_app.scrape_name();
				product.image = usi_app.scrape_image();
				product.price = usi_app.scrape_price();
				product.pid = usi_app.scrape_sku() + "_" + usi_app.locale;
				product.extra = JSON.stringify({
					stock: usi_app.scrape_stock(),
					old_price: usi_app.scrape_msrp(),
					brand: '',
					category: '',
					variant: ''
				});
				return product;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load_product_data = function (options) {
			try {
				usi_app.product_rec_callback = options.callback;
				var queryStr = "";
				if (options.siteID) queryStr += '?siteID=' + options.siteID;
				if (options.association_siteID) queryStr += '&association_siteID=' + options.association_siteID;
				if (options.pid) queryStr += '&pid=' + options.pid;
				if (options.match) queryStr += '&match=' + options.match.replace(",,", ",");
				if (options.nomatch) queryStr += '&nomatch=' + options.nomatch.replace(",,", ",");
				if (options.rows) queryStr += '&rows=' + options.rows;
				if (options.days_back) queryStr += '&days_back=' + options.days_back;
				if (options.force_exact) queryStr += '&force_exact=1';
				if (options.less_expensive) queryStr += '&less_expensive=1';
				usi_commons.load_script(usi_commons.cdn + '/utility/product_recommendations.jsp' + queryStr);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.boostbar = {
			load: function (boost_txt) {
				usi_commons.log("usi_app.boostbar()");
				if (boost_txt.length > 0 && !document.getElementById('usi_boost_container') && !usi_cookies.value_exists("usi_suppress_boost")) {
					// Assign boost bar styles according to condition
					var bg_color = usi_app.region === "eu" ? "#000000" : "#829EB6";
					var close_right = "5px";
					var padding = "1.1em 15%";
					var usi_boost_container = document.createElement('div');
					var close_button = '<a href="javascript:usi_app.boostbar.close();" style="min-width: 50px; height:100%; width:10%; right:' + close_right + '; top:9px; bottom:0; position:absolute; color:#fff; font-size:1.5em; text-decoration:none; line-height:1.6em">&times;</a>';
					usi_boost_container.innerHTML = [
						'<div id="usi_boost_container" style="position:fixed; bottom:0; left:0; width:100%; text-align:center; font-size:1.2em; background:' + bg_color + '; color:#fff; padding:' + padding + '; line-height: 1.2em; z-index:99999999999;">',
						close_button,
						'<span>' + boost_txt + '</span>',
						'</div>'
					].join('');
					document.body.appendChild(usi_boost_container);
				}
			},
			close: function () {
				var bar = document.getElementById('usi_boost_container');
				if (bar != null) {
					usi_cookies.set("usi_suppress_boost", '1', usi_cookies.expire_time.day, true);
					bar.parentNode.removeChild(bar);
				}
			}
		};

		// --------------------------------------------------------------------------
		// --------------------------------------------------------------------------
		// ----------------------------- CART REBUILDER -----------------------------
		// --------------------------------------------------------------------------
		// --------------------------------------------------------------------------
		// <editor-fold desc=" CART REBUILDER ">

		/**
		 * DO NOT DELETE - This is called within
		 * @param pid
		 * @param cb
		 */
		usi_app.add_single_item_to_cart = function (pid, cb) {
			try {
				if (pid && typeof cb === "function" && window['GLOBAL_ACCOUNT_CONFIG'] && window['GLOBAL_ACCOUNT_CONFIG']['DOMAIN_XMAN']) {
					var url = window['GLOBAL_ACCOUNT_CONFIG']['DOMAIN_XMAN'] + '/xman/cart/batch-add';
					var xhr = new XMLHttpRequest();
					xhr.open("POST", url, true);
					xhr.setRequestHeader("accept", "application/json, text/plain, */*");
					xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
					xhr.withCredentials = true;
					xhr.onreadystatechange = function () {
						if (xhr.readyState === 4) cb();
					};
					var data = '{"cartItems":[{"sku":"' + pid + '","qty":1,"subSku":[]}],"storeCode":"' + usi_app.locale + '","invite":""}';

					xhr.send(data);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		/**
		 * Keep a dictionary of all skus added used when rebuilding carts later
		 * @param params
		 */
		usi_app.record_cart_rebuilder_params = function (params) {
			try {
				if (params) {
					var json_params = JSON.parse(params);
					if (json_params && json_params.cartItems && json_params.cartItems.length > 0) {

						// Fetch original cart
						var cart = usi_cookies.get_json("usi_cart_data");
						if (!cart) cart = {};

						// Update original cart
						for (var i = 0; i < json_params.cartItems.length; i++) {
							var sku = json_params.cartItems[i].sku;
							if (sku) {
								if (cart[sku] && cart[sku].qty) {
									// Item already in cart, add to quantity
									json_params.cartItems[i].qty = json_params.cartItems[i].qty + cart[sku].qty;
									cart[sku].qty = json_params.cartItems[i].qty
									cart[sku].params = json_params.cartItems[i];
								} else {
									// New item added
									cart[sku] = {
										params: json_params.cartItems[i],
										qty: json_params.cartItems[i].qty
									}
								}
							}
						}

						// Save new cart
						usi_cookies.set_json("usi_cart_data", cart, usi_cookies.expire_time.week);
						usi_commons.log('[ record_cart_rebuilder_params ] cart:', cart);
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.rebuild = function (err, response) {
			try {
				if (response) {
					// Save required data as JSON in session as 'usi_cart'
					var usi_cart = response['usi_cart'];
					if (usi_cart) {
						// Show message while rebuilding
						var alert = document.querySelector(".hint-msg");
						if (alert != null) {
							alert.innerHTML = "One moment while we rebuild your cart...";
						} else {
							return usi_commons.log("[ rebuild ] Items in cart, don't rebuild");
						}
						usi_app.rebuild_cart(usi_cart);
					}
				} else {
					usi_commons.report_error(err);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		/**
		 * Method to testing cart rebuilder
		 */
		usi_app.rebuild_cart = function (cart) {
			try {
				if (!cart) return;
				if (window['GLOBAL_ACCOUNT_CONFIG'] && window['GLOBAL_ACCOUNT_CONFIG']['DOMAIN_XMAN']) {
					var url = window['GLOBAL_ACCOUNT_CONFIG']['DOMAIN_XMAN'] + '/xman/cart/batch-add';

					// Build params object
					var params = {
						"cartItems": [],
						"storeCode": usi_app.locale,
						"invite": ""
					};
					for (var prop in cart) {
						if (Object.prototype.hasOwnProperty.call(cart, prop)) {
							params['cartItems'].push({
								"sku": prop,
								"qty": cart[prop].params.qty,
								"subSku": cart[prop].params.subSku
							});
						}
					}

					// Add items to cart
					var xhr = new XMLHttpRequest();
					xhr.open("POST", url, true);
					xhr.setRequestHeader("accept", "application/json, text/plain, */*");
					xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
					xhr.withCredentials = true;
					xhr.onreadystatechange = function () {
						if (xhr.readyState === 4) {
							usi_cookies.set("usi_suppress_cr", '1', usi_cookies.expire_time.hour, true);
							setTimeout(function () {
								location.href = location.href.split('?')[0];
							}, 500);
						}
					};
					var data = JSON.stringify(params);
					xhr.send(data);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		// </editor-fold>

		/**
		 * Wait for window object to populate
		 * @param count
		 */
		usi_app.check_product_page_data = function (count) {
			try {
				usi_commons.log('[ check_product_page_data ]', window['ecommerce']);
				if ((window['ecommerce'] && window['ecommerce']['detail'] && window['ecommerce']['detail']['products']) || count >= 20) {
					usi_app.main();
				} else {
					setTimeout(function () {
						usi_app.check_product_page_data(count + 1);
					}, 1000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.pre_main = function (count) {
			try {
				if (count > 10) return;

				// Get current store locale
				usi_app.locale = document.getElementById("_current_store") ? document.getElementById("_current_store").value : window['currentStore'];
				if (!usi_app.locale && window['OVERSEAS_BASE'] && window['OVERSEAS_BASE']['site'] && window['OVERSEAS_BASE']['site']['store']) usi_app.locale = window['OVERSEAS_BASE']['site']['store'];

				usi_app.local_link = "https://onepluscom.pxf.io/c/16669/966195/12532?u=";
				if (usi_app.locale == "fr") {
					usi_app.local_link = "https://oneplusfr.sjv.io/c/16669/1103249/14044?u=";
				} else if (usi_app.locale == "de") {
					usi_app.local_link = "https://oneplus-de.pxf.io/c/16669/1126192/14043?u=";
				} else if (usi_app.locale == "uk" || usi_app.locale == "es" || usi_app.locale == "it" || usi_app.locale == "be_fr" || usi_app.locale == "be_nl") {
					usi_app.local_link = "https://oneplusuk.sjv.io/c/16669/1103240/14042?u=";
				}
				// Try again if needed
				if (!usi_app.locale) {
					setTimeout(function () {
						usi_app.pre_main(count + 1);
					}, 1000);
				} else {

					// Extract clean url
					usi_app.url = new usi_url.URL(location.href.toLowerCase());
					usi_app.path = usi_app.url.path.full;
					if (usi_app.locale != 'us' && usi_app.url.path.full.indexOf('/' + usi_app.locale) !== -1) usi_app.path = usi_app.url.path.full.replace('/' + usi_app.locale, '');
					if (!usi_app.path) usi_app.path = '/';

					// Set region
					usi_app.region = "";
					if (usi_app.locale && "us|ca_en|ca_fr|mx".indexOf(usi_app.locale) != -1) usi_app.region = "na";
					if (usi_app.locale && "uk|es|fr|de|it|be_fr|be_nl".indexOf(usi_app.locale) != -1) usi_app.region = "eu";

					// Set pages
					usi_app.is_entrance_page = document.referrer.indexOf("oneplus") == -1;
					usi_app.is_home_page = `usi_app.path == '/';`
					usi_app.is_cart_page = usi_app.path.indexOf('/jcart') !== -1;
					usi_app.is_checkout_page = usi_app.path.indexOf('/checkout/onepage') !== -1;
					usi_app.is_accessory_page = window['google_tag_params'] && window['google_tag_params']['ecomm_pagetype'] === 'Product Page - Accessories';
					usi_app.is_product_page = usi_app.path.indexOf('/product/') !== -1 ||
						document.querySelector('.product-buy-button.phone-buy-button') !== null;

					// Continue to main
					usi_commons.log('[ pre_main ] locale: ' + usi_app.locale + ' | region: ' + usi_app.region + ' | path: ' + usi_app.path);
					if (usi_app.is_product_page) {
						usi_app.check_product_page_data(0);
					} else {
						usi_app.main();
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.promos_one_off = [
// ========================= BEGIN NEW (February 23) =======================
			{
				"locale": "US",
				"url": "/oneplus-11",
				"start": "2023-02-07",
				"end": "2023-02-13",
				"incentive": "Up to $500 Trade-in Bonus",
				"headline": "Save up to $500 Trade-in Bonus",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "US",
				"url": "/oneplus-11",
				"start": "2023-02-16",
				"end": "2023-02-22",
				"incentive": "Free memory upgrade to Salami 256GB",
				"headline": "Get Free memory upgrade to Salami 256GB",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "US",
				"url": "/oneplus-10pro",
				"start": "2023-01-30",
				"end": "2023-02-12",
				"incentive": "Up to $200 OFF",
				"headline": "Save up to $200 OFF",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "US",
				"url": "/oneplus-10t",
				"start": "2023-01-30",
				"end": "2023-02-05",
				"incentive": "$100 OFF",
				"headline": "Save $100 OFF",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "US",
				"url": "/oneplus-n200-5g",
				"start": "2023-01-30",
				"end": "2023-02-19",
				"incentive": "$50 OFF",
				"headline": "Save $50 OFF",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "US",
				"url": "/oneplus-10-pro",
				"start": "2023-02-13",
				"end": "2023-02-26",
				"incentive": "Up to $150 OFF",
				"headline": "Save up to $150 OFF",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "US",
				"url": "/oneplus-10t",
				"start": "2023-02-06",
				"end": "2023-02-26",
				"incentive": "Up to $200 OFF",
				"headline": "Save up to $200 OFF",
				"coupon": "10T50",
				"cta": "Shop Now"
			},
			{
				"locale": "US",
				"url": "/oneplus-n200-5g",
				"start": "2023-02-20",
				"end": "2023-02-26",
				"incentive": "$40 OFF",
				"headline": "Save $40 OFF",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "US",
				"url": "/oneplus-n20-5g",
				"start": "2023-02-06",
				"end": "2023-02-26",
				"incentive": "$50 OFF",
				"headline": "Save $50 OFF",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "US",
				"url": "/oneplus-nord-buds",
				"start": "2023-02-06",
				"end": "2023-02-26",
				"incentive": "$10 OFF",
				"headline": "Save $10 OFF",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "US",
				"url": "/oneplus-buds-z2",
				"start": "2023-02-06",
				"end": "2023-02-26",
				"incentive": "$20 OFF",
				"headline": "Save $20 OFF",
				"coupon": "",
				"cta": "Shop Now"
			},

// ========================= BEGIN OLD =======================
			{
				"locale": "uk",
				"url": "/oneplus-10t",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u00A380 and use code to get extra \u00A320 OFF",
				"headline": "Save \u00A380 and use code to get extra \u00A320 OFF",
				"coupon": "OPNYR2",
				"cta": "Redeem Now"
			},
			{
				"locale": "uk",
				"url": "/oneplus-nord-2t-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u00A330 and use code to get extra \u00A310 OFF",
				"headline": "Save \u00A330 and use code to get extra \u00A310 OFF",
				"coupon": "OPNYR2",
				"cta": "Redeem Now"
			},
			{
				"locale": "uk",
				"url": "/oneplus-nord-2t-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u00A360 and use code to get extra \u00A310 OFF",
				"headline": "Save \u00A360 and use code to get extra \u00A310 OFF",
				"coupon": "OPNYR2",
				"cta": "Redeem Now"
			},
			{
				"locale": "uk",
				"url": "/oneplus-nord-ce-2-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u00A350",
				"headline": "Save \u00A350",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "uk",
				"url": "/oneplus-nord-ce-2-lite-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u00A340",
				"headline": "Save \u00A340",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "uk",
				"url": "/oneplus-buds-pro",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u00A340 and use code to get extra \u00A320 OFF",
				"headline": "Save \u00A340 and use code to get extra \u00A320 OFF",
				"coupon": "OPNYRAC2",
				"cta": "Redeem Now"
			},
			{
				"locale": "uk",
				"url": "/oneplus-buds-z2",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u00A320 and use code to get extra \u00A320 OFF",
				"headline": "Save \u00A320 and use code to get extra \u00A320 OFF",
				"coupon": "OPNYRAC2",
				"cta": "Redeem Now"
			},
			{
				"locale": "uk",
				"url": "/oneplus-nord-buds",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u00A35",
				"headline": "Save \u00A35",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "uk",
				"url": "/oneplus-nord-wired-earphones",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u00A35",
				"headline": "Save \u00A35",
				"coupon": "",
				"cta": "Shop Now"
			},
			{
				"locale": "fr",
				"url": "/oneplus-10-pro",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "150 \u20AC sur et 50 \u20AC en plus avec le code \"OPNYR2\"",
				"headline": "\u00C9conomisez 150 \u20AC sur et 50 \u20AC en plus avec le code \"OPNYR2\"",
				"coupon": "OPNYR2",
				"cta": "Utiliser maintenant"
			},
			{
				"locale": "fr",
				"url": "/oneplus-10t",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "80 \u20AC sur et 20 \u20AC en plus avec le code \"OPNYR2\"",
				"headline": "\u00C9conomisez 80 \u20AC sur et 20 \u20AC en plus avec le code \"OPNYR2\"",
				"coupon": "OPNYR2",
				"cta": "Utiliser maintenant"
			},
			{
				"locale": "fr",
				"url": "/oneplus-nord-2t-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "30 \u20AC sur et 10 \u20AC en plus avec le code \"OPNYR2\"",
				"headline": "\u00C9conomisez 30 \u20AC sur et 10 \u20AC en plus avec le code \"OPNYR2\"",
				"coupon": "OPNYR2",
				"cta": "Utiliser maintenant"
			},
			{
				"locale": "fr",
				"url": "/oneplus-nord-2t-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "60 \u20AC sur et 10 \u20AC en plus avec le code \"OPNYR2\"",
				"headline": "\u00C9conomisez 60 \u20AC sur et 10 \u20AC en plus avec le code \"OPNYR2\"",
				"coupon": "OPNYR2",
				"cta": "Utiliser maintenant"
			},
			{
				"locale": "fr",
				"url": "/oneplus-nord-ce-2-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "50\u20AC",
				"headline": "\u00C9conomisez 50\u20AC",
				"coupon": "",
				"cta": "Achetez maintenant"
			},
			{
				"locale": "fr",
				"url": "/oneplus-nord-ce-2-lite-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "50\u20AC",
				"headline": "\u00C9conomisez 50\u20AC",
				"coupon": "",
				"cta": "Achetez maintenant"
			},
			{
				"locale": "fr",
				"url": "/oneplus-buds-pro",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "40 \u20AC sur et 20 \u20AC en plus avec le code \"OPNYRAC2\"",
				"headline": "\u00C9conomisez 40 \u20AC sur et 20 \u20AC en plus avec le code \"OPNYRAC2\"",
				"coupon": "OPNYRAC2",
				"cta": "Utiliser maintenant"
			},
			{
				"locale": "fr",
				"url": "/oneplus-buds-z2",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "20 \u20AC sur et 20 \u20AC en plus avec le code \"OPNYRAC2\"",
				"headline": "\u00C9conomisez 20 \u20AC sur et 20 \u20AC en plus avec le code \"OPNYRAC2\"",
				"coupon": "OPNYRAC2",
				"cta": "Utiliser maintenant"
			},
			{
				"locale": "fr",
				"url": "/oneplus-nord-buds",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "5\u20AC",
				"headline": "\u00C9conomisez 5\u20AC",
				"coupon": "",
				"cta": "Achetez maintenant"
			},
			{
				"locale": "fr",
				"url": "/oneplus-nord-wired-earphones",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "5\u20AC",
				"headline": "\u00C9conomisez 5\u20AC",
				"coupon": "",
				"cta": "Achetez maintenant"
			},
			{
				"locale": "be_nl",
				"url": "/oneplus-10-pro",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u20AC 150 op en profiteer van \u20AC 50 extra korting met code OPNYR2.",
				"headline": "Bespaar \u20AC 150 op en profiteer van \u20AC 50 extra korting met code OPNYR2.",
				"coupon": "OPNYR2",
				"cta": "Nu verzilveren"
			},
			{
				"locale": "be_nl",
				"url": "/oneplus-10t",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u20AC 80 op en profiteer van \u20AC 20 extra korting met code OPNYR2.",
				"headline": "Bespaar \u20AC 80 op en profiteer van \u20AC 20 extra korting met code OPNYR2.",
				"coupon": "OPNYR2",
				"cta": "Nu verzilveren"
			},
			{
				"locale": "be_nl",
				"url": "/oneplus-nord-2t-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u20AC 30 op en profiteer van \u20AC 10 extra korting met code OPNYR2.",
				"headline": "Bespaar \u20AC 30 op en profiteer van \u20AC 10 extra korting met code OPNYR2.",
				"coupon": "OPNYR2",
				"cta": "Nu verzilveren"
			},
			{
				"locale": "be_nl",
				"url": "/oneplus-nord-2t-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u20AC 60 op en profiteer van \u20AC 10 extra korting met code OPNYR2.",
				"headline": "Bespaar \u20AC 60 op en profiteer van \u20AC 10 extra korting met code OPNYR2.",
				"coupon": "OPNYR2",
				"cta": "Nu verzilveren"
			},
			{
				"locale": "be_nl",
				"url": "/oneplus-nord-ce-2-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "50\u20AC",
				"headline": "Bespaar 50\u20AC",
				"coupon": "",
				"cta": "Bestel nu"
			},
			{
				"locale": "be_nl",
				"url": "/oneplus-nord-ce-2-lite-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "50\u20AC",
				"headline": "Bespaar 50\u20AC",
				"coupon": "",
				"cta": "Bestel nu"
			},
			{
				"locale": "be_nl",
				"url": "/oneplus-buds-pro",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u20AC 40 op en profiteer van \u20AC 20 extra korting met code OPNYRAC2.",
				"headline": "Bespaar \u20AC 40 op en profiteer van \u20AC 20 extra korting met code OPNYRAC2.",
				"coupon": "OPNYRAC2",
				"cta": "Nu verzilveren"
			},
			{
				"locale": "be_nl",
				"url": "/oneplus-buds-z2",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u20AC 20 op en profiteer van \u20AC 20 extra korting met code OPNYRAC2.",
				"headline": "Bespaar \u20AC 20 op en profiteer van \u20AC 20 extra korting met code OPNYRAC2.",
				"coupon": "OPNYRAC2",
				"cta": "Nu verzilveren"
			},
			{
				"locale": "be_nl",
				"url": "/oneplus-nord-buds",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "5\u20AC",
				"headline": "Bespaar 5\u20AC",
				"coupon": "",
				"cta": "Bestel nu"
			},
			{
				"locale": "be_nl",
				"url": "/oneplus-nord-wired-earphones",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "5\u20AC",
				"headline": "Bespaar 5\u20AC",
				"coupon": "",
				"cta": "Bestel nu"
			},
			{
				"locale": "be_fr",
				"url": "/oneplus-10-pro",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "150 \u20AC sur et 50 \u20AC en plus avec le code \"OPNYR2\"",
				"headline": "\u00C9conomisez 150 \u20AC sur et 50 \u20AC en plus avec le code \"OPNYR2\"",
				"coupon": "OPNYR2",
				"cta": "Utiliser maintenant"
			},
			{
				"locale": "be_fr",
				"url": "/oneplus-10t",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "80 \u20AC sur et 20 \u20AC en plus avec le code \"OPNYR2\"",
				"headline": "\u00C9conomisez 80 \u20AC sur et 20 \u20AC en plus avec le code \"OPNYR2\"",
				"coupon": "OPNYR2",
				"cta": "Utiliser maintenant"
			},
			{
				"locale": "be_fr",
				"url": "/oneplus-nord-2t-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "30 \u20AC sur et 10 \u20AC en plus avec le code \"OPNYR2\"",
				"headline": "\u00C9conomisez 30 \u20AC sur et 10 \u20AC en plus avec le code \"OPNYR2\"",
				"coupon": "OPNYR2",
				"cta": "Utiliser maintenant"
			},
			{
				"locale": "be_fr",
				"url": "/oneplus-nord-2t-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "60 \u20AC sur et 10 \u20AC en plus avec le code \"OPNYR2\"",
				"headline": "\u00C9conomisez 60 \u20AC sur et 10 \u20AC en plus avec le code \"OPNYR2\"",
				"coupon": "OPNYR2",
				"cta": "Utiliser maintenant"
			},
			{
				"locale": "be_fr",
				"url": "/oneplus-nord-ce-2-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "50\u20AC",
				"headline": "\u00C9conomisez 50\u20AC",
				"coupon": "",
				"cta": "Achetez maintenant"
			},
			{
				"locale": "be_fr",
				"url": "/oneplus-nord-ce-2-lite-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "50\u20AC",
				"headline": "\u00C9conomisez 50\u20AC",
				"coupon": "",
				"cta": "Achetez maintenant"
			},
			{
				"locale": "be_fr",
				"url": "/oneplus-buds-pro",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "40 \u20AC sur et 20 \u20AC en plus avec le code \"OPNYRAC2\"",
				"headline": "\u00C9conomisez 40 \u20AC sur et 20 \u20AC en plus avec le code \"OPNYRAC2\"",
				"coupon": "OPNYRAC2",
				"cta": "Utiliser maintenant"
			},
			{
				"locale": "be_fr",
				"url": "/oneplus-buds-z2",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "20 \u20AC sur et 20 \u20AC en plus avec le code \"OPNYRAC2\"",
				"headline": "\u00C9conomisez 20 \u20AC sur et 20 \u20AC en plus avec le code \"OPNYRAC2\"",
				"coupon": "OPNYRAC2",
				"cta": "Utiliser maintenant"
			},
			{
				"locale": "be_fr",
				"url": "/oneplus-nord-buds",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "5\u20AC",
				"headline": "\u00C9conomisez 5\u20AC",
				"coupon": "",
				"cta": "Achetez maintenant"
			},
			{
				"locale": "be_fr",
				"url": "/oneplus-nord-wired-earphones",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "5\u20AC",
				"headline": "\u00C9conomisez 5\u20AC",
				"coupon": "",
				"cta": "Achetez maintenant"
			},
			{
				"locale": "it",
				"url": "/oneplus-10-pro",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "150 \u20AC e altri 50 \u20AC usando il codice \"OPNYR2\".",
				"headline": "Risparmia 150 \u20AC e altri 50 \u20AC usando il codice \"OPNYR2\".",
				"coupon": "OPNYR2",
				"cta": "Riscatta Ora"
			},
			{
				"locale": "it",
				"url": "/oneplus-10t",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "80 \u20AC e altri 20 \u20AC usando il codice \"OPNYR2\".",
				"headline": "Risparmia 80 \u20AC e altri 20 \u20AC usando il codice \"OPNYR2\".",
				"coupon": "OPNYR2",
				"cta": "Riscatta Ora"
			},
			{
				"locale": "it",
				"url": "/oneplus-nord-2t-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "30 \u20AC e altri 10 \u20AC usando il codice \"OPNYR2\".",
				"headline": "Risparmia 30 \u20AC e altri 10 \u20AC usando il codice \"OPNYR2\".",
				"coupon": "OPNYR2",
				"cta": "Riscatta Ora"
			},
			{
				"locale": "it",
				"url": "/oneplus-nord-2t-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "60 \u20AC e altri 10 \u20AC usando il codice \"OPNYR2\".",
				"headline": "Risparmia 60 \u20AC e altri 10 \u20AC usando il codice \"OPNYR2\".",
				"coupon": "OPNYR2",
				"cta": "Riscatta Ora"
			},
			{
				"locale": "it",
				"url": "/oneplus-nord-ce-2-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "50\u20AC",
				"headline": "Risparmia 50\u20AC",
				"coupon": "",
				"cta": "Acquista ora"
			},
			{
				"locale": "it",
				"url": "/oneplus-nord-ce-2-lite-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "50\u20AC",
				"headline": "Risparmia 50\u20AC",
				"coupon": "",
				"cta": "Acquista ora"
			},
			{
				"locale": "it",
				"url": "/oneplus-buds-pro",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "40 \u20AC e altri 20 \u20AC usando il codice \"OPNYRAC2\".",
				"headline": "Risparmia 40 \u20AC e altri 20 \u20AC usando il codice \"OPNYRAC2\".",
				"coupon": "OPNYRAC2",
				"cta": "Riscatta Ora"
			},
			{
				"locale": "it",
				"url": "/oneplus-buds-z2",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "20 \u20AC e altri 20 \u20AC usando il codice \"OPNYRAC2\".",
				"headline": "Risparmia 20 \u20AC e altri 20 \u20AC usando il codice \"OPNYRAC2\".",
				"coupon": "OPNYRAC2",
				"cta": "Riscatta Ora"
			},
			{
				"locale": "it",
				"url": "/oneplus-nord-buds",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "5\u20AC",
				"headline": "Risparmia 5\u20AC",
				"coupon": "",
				"cta": "Acquista ora"
			},
			{
				"locale": "it",
				"url": "/oneplus-nord-wired-earphones",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "5\u20AC",
				"headline": "Risparmia 5\u20AC",
				"coupon": "",
				"cta": "Acquista ora"
			},
			{
				"locale": "es",
				"url": "/oneplus-10-pro",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "150 \u20AC + descuento adicional de 50 \u20AC con el c\u00F3digo \"OPNYR2\".",
				"headline": "Ahorre 150 \u20AC + descuento adicional de 50 \u20AC con el c\u00F3digo \"OPNYR2\".",
				"coupon": "OPNYR2",
				"cta": "Comprar ahora"
			},
			{
				"locale": "es",
				"url": "/oneplus-10t",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "80 \u20AC + descuento adicional de 20 \u20AC con el c\u00F3digo \"OPNYR2\".",
				"headline": "Ahorre 80 \u20AC + descuento adicional de 20 \u20AC con el c\u00F3digo \"OPNYR2\".",
				"coupon": "OPNYR2",
				"cta": "Comprar ahora"
			},
			{
				"locale": "es",
				"url": "/oneplus-nord-2t-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "30 \u20AC + descuento adicional de 10 \u20AC con el c\u00F3digo \"OPNYR2\".",
				"headline": "Ahorre 30 \u20AC + descuento adicional de 10 \u20AC con el c\u00F3digo \"OPNYR2\".",
				"coupon": "OPNYR2",
				"cta": "Comprar ahora"
			},
			{
				"locale": "es",
				"url": "/oneplus-nord-2t-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "60 \u20AC + descuento adicional de 10 \u20AC con el c\u00F3digo \"OPNYR2\".",
				"headline": "Ahorre 60 \u20AC + descuento adicional de 10 \u20AC con el c\u00F3digo \"OPNYR2\".",
				"coupon": "OPNYR2",
				"cta": "Comprar ahora"
			},
			{
				"locale": "es",
				"url": "/oneplus-nord-ce-2-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "50\u20AC",
				"headline": "Ahorre 50\u20AC",
				"coupon": "",
				"cta": "Compra ya"
			},
			{
				"locale": "es",
				"url": "/oneplus-nord-ce-2-lite-5g",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "50\u20AC",
				"headline": "Ahorre 50\u20AC",
				"coupon": "",
				"cta": "Compra ya"
			},
			{
				"locale": "es",
				"url": "/oneplus-buds-pro",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "40 \u20AC + descuento adicional de 20 \u20AC con el c\u00F3digo \"OPNYRAC2\".",
				"headline": "Ahorre 40 \u20AC + descuento adicional de 20 \u20AC con el c\u00F3digo \"OPNYRAC2\".",
				"coupon": "OPNYRAC2",
				"cta": "Comprar ahora"
			},
			{
				"locale": "es",
				"url": "/oneplus-buds-z2",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "20 \u20AC + descuento adicional de 20 \u20AC con el c\u00F3digo \"OPNYRAC2\".",
				"headline": "Ahorre 20 \u20AC + descuento adicional de 20 \u20AC con el c\u00F3digo \"OPNYRAC2\".",
				"coupon": "OPNYRAC2",
				"cta": "Comprar ahora"
			},
			{
				"locale": "es",
				"url": "/oneplus-nord-buds",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "5\u20AC",
				"headline": "Ahorre 5\u20AC",
				"coupon": "",
				"cta": "Compra ya"
			},
			{
				"locale": "es",
				"url": "/oneplus-nord-wired-earphones",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "5\u20AC",
				"headline": "Ahorre 5\u20AC",
				"coupon": "",
				"cta": "Compra ya"
			}
		];
		//Add this when testing: testing: true
		usi_app.promos_general = [
			{
				"locale": "us",
				"start": "2023-02-07",
				"end": "2023-03-01",
				"incentive": "10\u0025 off",
				"threshold": 900,
				"topline": "A great deal is calling.",
				"headline": "10\u0025 off",
				"subhead": "with purchase of \u0024900 or more",
				"cta": "Redeem Now",
				"coupon": "UPST3"
			},
			{
				"locale": "us",
				"start": "2023-02-07",
				"end": "2023-03-01",
				"incentive": "8\u0025 off",
				"threshold": 800,
				"topline": "A great deal is calling.",
				"headline": "8\u0025 off",
				"subhead": "with purchase of \u0024800 or more",
				"cta": "Redeem Now",
				"coupon": "UPST2"
			},
			{
				"locale": "us",
				"start": "2023-02-07",
				"end": "2023-03-01",
				"incentive": "3\u0025 off",
				"threshold": 700,
				"topline": "A great deal is calling.",
				"headline": "3\u0025 off",
				"subhead": "with purchase of \u0024700 or more",
				"cta": "Redeem Now",
				"coupon": "UPST1"
			},
			{
				"locale": "uk",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u00A310 off",
				"threshold": 300,
				"topline": "A great deal is calling.",
				"headline": "\u00A310 off",
				"subhead": "with purchase of \u00A3300 or more",
				"cta": "Redeem Now",
				"coupon": "UPSEOP300"
			},
			{
				"locale": "de",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "Sparen Sie 10 \u20AC off",
				"threshold": 300,
				"topline": "Vieles ruft.",
				"headline": "Sparen Sie 10 \u20AC off",
				"subhead": "bei einem Kauf von mindestens \u20AC300",
				"cta": "Jetzt einl\u00F6sen",
				"coupon": "UPSEOP300"
			},
			{
				"locale": "fr",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u00C9conomisez 10 \u20AC off",
				"threshold": 300,
				"topline": "Beaucoup appelle.",
				"headline": "\u00C9conomisez 10 \u20AC off",
				"subhead": "avec un achat de \u20AC300 ou plus",
				"cta": "Utiliser maintenant",
				"coupon": "UPSEOP300"
			},
			{
				"locale": "be_nl",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "Bespaar 10 \u20AC",
				"threshold": 300,
				"topline": "De beste aanbiedingen",
				"headline": "Bespaar 10 \u20AC",
				"subhead": "Bij een aankoop van \u20AC300 of meer",
				"cta": "Nu verzilveren",
				"coupon": "UPSEOP300"
			},
			{
				"locale": "be_fr",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "\u00C9conomisez 10 \u20AC off",
				"threshold": 300,
				"topline": "Beaucoup appelle.",
				"headline": "\u00C9conomisez 10 \u20AC off",
				"subhead": "avec un achat de \u20AC300 ou plus",
				"cta": "Utiliser maintenant",
				"coupon": "UPSEOP300"
			},
			{
				"locale": "it",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "Risparmia 10 \u20AC off",
				"threshold": 300,
				"topline": "Molto sta chiamando.",
				"headline": "Risparmia 10 \u20AC off",
				"subhead": "con una spesa minima di \u20AC300",
				"cta": "Riscatta Ora",
				"coupon": "UPSEOP300"
			},
			{
				"locale": "es",
				"start": "2023-01-01",
				"end": "2023-02-28",
				"incentive": "Ahorre 10 \u20AC off",
				"threshold": 300,
				"topline": "una gran oportunidad te espera",
				"headline": "Ahorre 10 \u20AC off",
				"subhead": "con la compra de \u20AC300 o m\u00E1s",
				"cta": "Comprar ahora",
				"coupon": "UPSEOP300"
			}
		];

		usi_dom.ready(function () {
			try {
				setTimeout(usi_app.pre_main, 2500);
			} catch (err) {
				usi_commons.report_error(err);
			}
		});
	} catch (err) {
		usi_commons.report_error(err);
	}
}