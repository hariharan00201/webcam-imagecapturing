package com.sma.app.controller;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@org.springframework.stereotype.Controller
public class Controller {

	private Map<String,Integer> ha=new HashMap<>();

	@RequestMapping("/")
	public String base()
	{
		return "index.jsp";
	}


	@RequestMapping(value = "/upload" , method = RequestMethod.POST)
	public void getImg(String regno , String imgg , HttpServletRequest req , HttpServletResponse res , HttpSession sc) throws IOException, ServletException
	{
		ha.put(regno, ha.getOrDefault(regno, 0)+1);
		if(ha.get(regno) > 10)
		{
			sc.setAttribute("regno", regno);
			RequestDispatcher rd=req.getRequestDispatcher("success.jsp");
			rd.forward(req, res);
		}
		else
		{
			System.out.println("successfull" + "    " +imgg.length()+"   "+regno + "    "+ ha.get(regno));
			//System.out.println(imgg.split(",")[1].substring(0,20));
			System.out.println(imgg.substring(0,40));

			System.out.println();


			byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(imgg.split(",")[1]);
			/*
			 * FileOutputStream fos = new
			 * FileOutputStream("C:\\Users\\akilesh\\Desktop\\CIP\\dummy" + "hari.png"); try
			 * { fos.write(imageBytes); } finally { fos.close(); }
			 */
			/*
			 * Decoder decoder = Base64.getDecoder(); byte[] decodedByte =
			 * imgg.getBytes(StandardCharsets.UTF_8);
			 * System.out.println(decodedByte.toString());
			 * 
			 */
			Path path=Paths.get("C:\\Users\\akilesh\\Desktop\\CIP\\dummy\\"+regno+"."+ha.get(regno)+".png");
			Files.write(path, imageBytes);


			/*
			 * FileOutputStream fos = new
			 * FileOutputStream("C:\\Users\\akilesh\\Desktop\\CIP\\dummy\\hari.png");
			 * fos.write(decodedByte); fos.close();
			 */

			if(ha.get(regno) < 10)
			{
				sc.setAttribute("count", ha.get(regno));
				sc.setAttribute("regno", regno);
				RequestDispatcher rd=req.getRequestDispatcher("index.jsp");
				rd.forward(req, res);
			}
			else
			{
				sc.setAttribute("regno", regno);
				RequestDispatcher rd=req.getRequestDispatcher("success.jsp");
				rd.forward(req, res);
			}
		}

	}
	//data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAoAAAAHgCAYAAAA10dzkAAAgAElEQVR4Xny9a8xt61Ue9s7bunzf3vsc+xxfuBhqO07smKqXJKKlAstAYuo
}
