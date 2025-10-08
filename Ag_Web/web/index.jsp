<%-- 
    Document   : index
    Created on : 07/10/2025, 21:53:15 p. m.
    Author     : etzan
--%>
<%@page import="modelo.Sangre"%>
<%@page import="modelo.Estudiante"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Estudiantes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- Encabezado -->
    <header class="bg-dark text-white py-3 mb-4 shadow">
        <div class="container">
            <h1 class="h3 mb-0"><i class="bi bi-person-lines-fill"></i> Gestión de Estudiantes</h1>
        </div>
    </header>

    <!-- Contenedor principal -->
    <div class="container">

        <!-- Botón para abrir modal -->
        <div class="mb-3 text-end">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal" onclick="limpiar()">
                <i class="bi bi-plus-circle"></i> Nuevo Estudiante
            </button>
        </div>

        <!-- Tabla de estudiantes -->
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <strong>Listado de Estudiantes</strong>
            </div>
            <div class="card-body p-0">
                <table class="table table-hover table-bordered align-middle text-center mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Carne</th>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>Dirección</th>
                            <th>Teléfono</th>
                            <th>Correo</th>
                            <th>Nacimiento</th>
                            <th>Sangre</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_estudiantes">
                        <%
                        Estudiante estudiante = new Estudiante();
                        DefaultTableModel tabla = estudiante.leer();
                        for (int i = 0; i < tabla.getRowCount(); i++) {
                            out.println("<tr data-id='" + tabla.getValueAt(i, 0) + "' data-id_p='" + tabla.getValueAt(i, 9) + "'>");
                            for (int j = 1; j <= 8; j++) {
                                out.println("<td>" + tabla.getValueAt(i, j) + "</td>");
                            }
                            out.println("</tr>");
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content shadow">

                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="modalLabel"><i class="bi bi-person-plus-fill"></i> Formulario Estudiante</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>

                    <div class="modal-body">
                        <form action="sr_estudiante" method="post">
                            <div class="row g-3">
                                <input type="hidden" name="txt_id" id="txt_id" value="0">

                                <div class="col-md-4">
                                    <label for="txt_carne" class="form-label"><b>Carne</b></label>
                                    <input type="text" class="form-control" name="txt_carne" id="txt_carne" required>
                                </div>

                                <div class="col-md-4">
                                    <label for="txt_nombres" class="form-label"><b>Nombres</b></label>
                                    <input type="text" class="form-control" name="txt_nombres" id="txt_nombres" required>
                                </div>

                                <div class="col-md-4">
                                    <label for="txt_apellidos" class="form-label"><b>Apellidos</b></label>
                                    <input type="text" class="form-control" name="txt_apellidos" id="txt_apellidos" required>
                                </div>

                                <div class="col-md-6">
                                    <label for="txt_direccion" class="form-label"><b>Dirección</b></label>
                                    <input type="text" class="form-control" name="txt_direccion" id="txt_direccion" required>
                                </div>

                                <div class="col-md-6">
                                    <label for="txt_telefono" class="form-label"><b>Teléfono</b></label>
                                    <input type="number" class="form-control" name="txt_telefono" id="txt_telefono" required>
                                </div>

                                <div class="col-md-6">
                                    <label for="txt_correo_electronico" class="form-label"><b>Correo Electrónico</b></label>
                                    <input type="email" class="form-control" name="txt_correo_electronico" id="txt_correo_electronico" required>
                                </div>

                                <div class="col-md-3">
                                    <label for="txt_fn" class="form-label"><b>Fecha Nacimiento</b></label>
                                    <input type="date" class="form-control" name="txt_fn" id="txt_fn" required>
                                </div>

                                <div class="col-md-3">
                                    <label for="drop_sangre" class="form-label"><b>Tipo Sangre</b></label>
                                    <select class="form-select" name="drop_sangre" id="drop_sangre" required>
                                        <%
                                            Sangre sangre = new Sangre();
                                            HashMap<String, String> drop = sangre.drop_sangre();
                                            for (String i : drop.keySet()) {
                                                out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>

                            <!-- Botones -->
                            <div class="mt-4 d-flex justify-content-end gap-2">
                                <button name="btn_agregar" value="agregar" class="btn btn-primary">
                                    <i class="bi bi-plus-circle"></i> Agregar
                                </button>
                                <button name="btn_modificar" value="modificar" class="btn btn-success">
                                    <i class="bi bi-pencil-square"></i> Modificar
                                </button>
                                <button name="btn_eliminar" value="eliminar" class="btn btn-danger" onclick="return confirm('¿Desea eliminar?')">
                                    <i class="bi bi-trash"></i> Eliminar
                                </button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                    <i class="bi bi-x-circle"></i> Cerrar
                                </button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

    <script>
        function limpiar() {
            $("#txt_id").val(0);
            $("#txt_carne").val('');
            $("#txt_nombres").val('');
            $("#txt_apellidos").val('');
            $("#txt_direccion").val('');
            $("#txt_telefono").val('');
            $("#txt_correo_electronico").val('');
            $("#txt_fn").val('');
            $("#drop_sangre").val('');
        }

        $('#tbl_estudiantes').on('click', 'tr td', function () {
            var target = $(event.target);
            var fila = target.closest('tr');
            $("#txt_id").val(fila.data('id'));
            $("#drop_sangre").val(fila.data('id_p'));

            var celdas = fila.find('td');
            $("#txt_carne").val(celdas.eq(0).text());
            $("#txt_nombres").val(celdas.eq(1).text());
            $("#txt_apellidos").val(celdas.eq(2).text());
            $("#txt_direccion").val(celdas.eq(3).text());
            $("#txt_telefono").val(celdas.eq(4).text());
            $("#txt_correo_electronico").val(celdas.eq(5).text());
            $("#txt_fn").val(celdas.eq(6).text());

            $('#myModal').modal('show');
        });
    </script>
<%
    String mensaje = (String) request.getAttribute("mensaje");
    String tipo = (String) request.getAttribute("tipo"); // success, danger, etc.
    if (mensaje != null && tipo != null) {
%>
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div class="toast align-items-center text-bg-<%= tipo %> border-0 show" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <%= mensaje %>
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<% } %>

</body>
</html>

