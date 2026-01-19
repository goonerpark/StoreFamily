package kr.co.storefamily.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class TestController {

	@RequestMapping(value="test")
	public String test() {
		return "test";
	}

	@RequestMapping(value="test_ok")
	public String test_ok(MultipartHttpServletRequest files) {
		String uploadFolder = "C:\\Users\\dlfbs\\Documents\\workspace-sts-3.9.18.RELEASE\\StoreFamily\\src\\main\\webapp\\resources\\img";
		List<MultipartFile> list = files.getFiles("files");

		for (MultipartFile element : list) {
			String fileRealName = element.getOriginalFilename();
			long size = element.getSize();

			System.out.println("파일명 : " + fileRealName);
			System.out.println("사이즈 : " + size);

			File saveFile = new File(uploadFolder + "\\" + fileRealName);
			try {
				System.out.println("성공");
				element.transferTo(saveFile);
			} catch(IllegalStateException e) {
				System.out.println("오류1");
				e.printStackTrace();
			} catch(IOException e) {
				System.out.println("오류2");
				e.printStackTrace();
			}
		}

		return "redirect:/test";
	}

}
