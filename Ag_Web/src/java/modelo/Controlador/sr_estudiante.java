/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import modelo.Estudiante;

public class sr_estudiante extends HttpServlet {

    Estudiante estudiante;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        estudiante = new Estudiante(
                request.getParameter("txt_carne"),
                Integer.parseInt(request.getParameter("drop_sangre")),
                Integer.parseInt(request.getParameter("txt_id")),
                request.getParameter("txt_nombres"),
                request.getParameter("txt_apellidos"),
                request.getParameter("txt_direccion"),
                request.getParameter("txt_telefono"),
                request.getParameter("txt_correo_electronico"),
                request.getParameter("txt_fn")
        );

        String mensaje = "";
        String tipo = "";

        // Agregar
        if ("agregar".equals(request.getParameter("btn_agregar"))) {
            if (estudiante.agregar() > 0) {
                mensaje = "✅ Estudiante agregado correctamente.";
                tipo = "success";
            } else {
                mensaje = "❌ Error al agregar estudiante.";
                tipo = "danger";
            }
        }

        // Modificar
        if ("modificar".equals(request.getParameter("btn_modificar"))) {
            if (estudiante.modificar() > 0) {
                mensaje = "✅ Estudiante modificado correctamente.";
                tipo = "success";
            } else {
                mensaje = "❌ Error al modificar estudiante.";
                tipo = "danger";
            }
        }

        // Eliminar
        if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
            if (estudiante.eliminar() > 0) {
                mensaje = "✅ Estudiante eliminado correctamente.";
                tipo = "success";
            } else {
                mensaje = "❌ Error al eliminar estudiante.";
                tipo = "danger";
            }
        }

        // Enviar mensaje a index.jsp
        request.setAttribute("mensaje", mensaje);
        request.setAttribute("tipo", tipo);
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Controlador para operaciones con estudiantes";
    }
}

