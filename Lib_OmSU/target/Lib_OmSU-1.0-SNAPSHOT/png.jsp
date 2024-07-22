<%@ page contentType="image/png" import="java.io.*, java.awt.*, java.awt.image.*, javax.imageio.*, java.util.*" %>
<%
    try{
        int x1 = Integer.parseInt(request.getParameter("x1"));
        int y1 = Integer.parseInt(request.getParameter("y1"));
        int x2 = Integer.parseInt(request.getParameter("x2"));
        int y2 = Integer.parseInt(request.getParameter("y2"));

        BufferedImage image = new BufferedImage(600, 600, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();
        g.setColor(Color.GREEN);
        g.drawLine(x1, y1, x2, y2);
        g.setColor(Color.CYAN);
        g.fillArc(200,200, 100,100, 45,270);
        g.setColor(Color.ORANGE);
        g.drawString("Hello world!", 300,300);
        g.fill3DRect(25, 25, 400, 30, false);
        ImageIO.write(image, "png", response.getOutputStream());
        response.getOutputStream().flush();
    }catch(Exception e){
        System.err.println("err = "+e.getMessage());
    }
%>