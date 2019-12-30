package com.oracle.cars.control;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import com.oracle.cars.model.Car;
import com.oracle.cars.model.CarDAO;

/**
 * Servlet implementation class CarServlet
 */
@WebServlet("/CarServlet")
@MultipartConfig //采用流的方式提交表单内容
public class CarServlet extends HttpServlet {
	private CarDAO  dao=new CarDAO();
	/**
	 * Servlet复用
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//只要调用CarServlet 都会进入这个方法， 然后再根据用户传过来的method参数做分流
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String method=request.getParameter("method");
		switch (method) {
			case "listAll":
			{
				System.out.println("查看所有的");
				//查询数据库获得所有二手车辆信息然后返回到页面上显示
				List<Car> cars=dao.listAllCars();
				
				//讲查询的数据存储到request范围内
				request.setAttribute("cars", cars);
				
				//数据存储完毕，跳转到页面上准备在页面上显示所有二手车信息
				request.getRequestDispatcher("carList.jsp").forward(request, response);
				
				
				break;
			}
			case "add":
			{
				System.out.println("添加");
				//1.获取表单页面上用户填写的数据
				String pinpaiming=request.getParameter("pinpaiming");//ctrl+alt+ 下箭头
				String xilie=request.getParameter("xilie");//ctrl+alt+ 下箭头
				String shoujia=request.getParameter("shoujia");//ctrl+alt+ 下箭头
				String gonglishu=request.getParameter("gonglishu");//ctrl+alt+ 下箭头
				String pailiang=request.getParameter("pailiang");//ctrl+alt+ 下箭头
				String yanse=request.getParameter("yanse");//ctrl+alt+ 下箭头
				
				
				//读取上传表单页面上的数据并将图像存储到服务器磁盘上，然后将图片路径添加到数据库里面，实现图片上传功能
				String fileName=request.getPart("zhaopian").getSubmittedFileName();
				Part  part=request.getPart("zhaopian");
				InputStream  inputStream=part.getInputStream();
				String uuidName=UUID.randomUUID()+fileName.substring(fileName.lastIndexOf("."),fileName.length());
				File newFile= new File(request.getRealPath("images"),"car/"+uuidName);
				FileOutputStream  outputStream=new  FileOutputStream(newFile);
				byte[] bs=new byte[1024];
				int length=-1;
				while((length=inputStream.read(bs))!=-1) {
					outputStream.write(bs,0,length);
					outputStream.flush();
				}
				outputStream.close();
				String zhaopian="images/car/"+uuidName;
				
				
				
				//2.将这些属性封装成一个java对象
				Car  car=new Car();
				car.setGonglishu(Integer.parseInt(gonglishu));
				car.setPailiang(pailiang);
				car.setPinpaiming(pinpaiming);
				car.setShoujia(Integer.parseInt(shoujia));
				car.setXilie(xilie);
				car.setYanse(yanse);
				car.setZhaopian(zhaopian);
				
				//3.调用dao方法，讲这个新添加的汽车信息插入到数据库表中
				boolean result=dao.addCar(car);
				
				//4.根据添加结果跳转页面
				if(result) {
					request.getRequestDispatcher("CarServlet?method=listAll").forward(request, response);
				}else {
					request.getRequestDispatcher("carAdd.jsp").forward(request, response);
				}
				break;
			}
			case "getCarInfo":
			{
				System.out.println("修改前的查询");
				//1.获取用户超链接传过来的汽车编号
				String carid=request.getParameter("carid");
				//2.调用dao查询出这个车辆信息
				Car car=dao.getCarDetailById(Integer.parseInt(carid));
				//3.将查询出来的汽车存储到request范围内
				request.setAttribute("car", car);
				//4.跳转到修改的jsp上显示这个车辆数据供用户修改操作
				request.getRequestDispatcher("carEdit.jsp").forward(request, response);
				break;
			}
			case "update":
			{
				System.out.println("修改");
				//1.还是先获取页面上用户修改后的车辆信息
				String pinpaiming=request.getParameter("pinpaiming");//ctrl+alt+ 下箭头
				String xilie=request.getParameter("xilie");//ctrl+alt+ 下箭头
				String shoujia=request.getParameter("shoujia");//ctrl+alt+ 下箭头
				String gonglishu=request.getParameter("gonglishu");//ctrl+alt+ 下箭头
				String pailiang=request.getParameter("pailiang");//ctrl+alt+ 下箭头
				String yanse=request.getParameter("yanse");//ctrl+alt+ 下箭头
				String carid=request.getParameter("carid");
				
				//2.将这些属性封装成一个java对象
				Car  car=new Car();
				car.setCarid(Integer.parseInt(carid));
				car.setGonglishu(Integer.parseInt(gonglishu));
				car.setPailiang(pailiang);
				car.setPinpaiming(pinpaiming);
				car.setShoujia(Integer.parseInt(shoujia));
				car.setXilie(xilie);
				car.setYanse(yanse);
				
				//3.调用dao方法，讲这个新添加的汽车信息插入到数据库表中
				boolean result=dao.updateCar(car);
				
				//4.根据修改结果跳转页面
				if(result) {
					request.getRequestDispatcher("CarServlet?method=listAll").forward(request, response);
				}else {
					request.getRequestDispatcher("carEdit.jsp").forward(request, response);
				}
				break;
			}
			case "delete":
			{
				System.out.println("删除");
				//1.获取用户超链接传过来的汽车编号
				String carid=request.getParameter("carid");
				//2.调用dao方法将这个编号的车辆删除掉
				boolean result=dao.deleteCar(Integer.parseInt(carid));
				//3.将删除的结果存储到request范围内，然后再jsp上判断结果提示用户操作结果
				request.setAttribute("deleteResult", result);
				//4.跳转到列表页面
				request.getRequestDispatcher("CarServlet?method=listAll").forward(request, response);
				break;
			}
	
		}
	}
}
