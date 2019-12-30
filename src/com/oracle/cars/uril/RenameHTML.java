package com.oracle.cars.uril;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;

import sun.security.provider.VerificationProvider;

public class RenameHTML {

	public static void main(String[] args) {
		updateSQL("C:\\Users\\Administrator\\Desktop\\car\\1.sql");
//		renameImgs("C:\\Users\\Administrator\\Desktop\\car");
//		File  dir=new  File("C:\\JavaEE_Projects\\Cars\\WebContent");
//		File[] files=dir.listFiles();
//		
//		for(File f:files) {
//			if(f.isFile()) {
//			System.out.println(f.getName());
//			System.out.println(f.getName().lastIndexOf("."));
//			String lastFliename=f.getName().substring(0,f.getName().lastIndexOf("."));
//			f.renameTo(new File(dir,lastFliename+".jsp"));
//			}
//		}

	}
	
	public static void  renameImgs(String path) {
		File  dir=new File(path);
		
		File[]  files=dir.listFiles();
		int n=1;
		for(File f:files) {
			f.renameTo(new File(dir,n+".jpg"));
			System.out.println(f.getAbsolutePath());
			n++;
		}
		
	}
	
	public static void updateSQL(String path) {
		try {
			BufferedReader  reader=new BufferedReader(new FileReader(path));
			BufferedWriter writer=new BufferedWriter(new FileWriter(path+"1"));
			String message=null;
			int n=1;
			while((message=reader.readLine())!=null) {
				message=message.replace(");", ",'images/car/"+n+".jpg');");
				message=message.replace("`pailiang`)", "`pailiang`,`zhaopian`)");
						
				writer.write(message);
				writer.newLine();
				writer.flush();
				n++;
				if(n>259)n=1;
				System.out.println(message);
			}
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
