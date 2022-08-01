package com.tpavlyshyn.fp.dao.impl;

import com.tpavlyshyn.fp.Fields;
import com.tpavlyshyn.fp.dao.PortDao;
import com.tpavlyshyn.fp.entity.Port;
import com.tpavlyshyn.fp.exceptions.DaoException;
import org.apache.log4j.Logger;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class PortDaoImpl implements PortDao {
    private final static Logger log = Logger.getLogger(PortDaoImpl.class);


    private static final String SQL__FIND_ALL_PORTS = "SELECT * " +
            "FROM port " +
            "INNER JOIN cruise_has_port chp ON port.id = chp.port_id " +
            "WHERE chp.cruise_id=? AND lang = ?;";

    private final DataSource ds;

    public PortDaoImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<Port> findAllByCruiseId(int cruiseId, String lang) throws DaoException {
        List<Port> portList = new ArrayList<>();
        try (Connection con = ds.getConnection();
             PreparedStatement pstmt = con.prepareStatement(SQL__FIND_ALL_PORTS)) {

            pstmt.setInt(1, cruiseId);
            pstmt.setString(2, lang);
            try(ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Port port = PortDaoImpl.extractPort(rs);
                    portList.add(port);
                }
            }

        } catch (SQLException ex) {
            log.error(ex.getMessage(), ex);
            throw new DaoException(ex);
        }
        return portList;
    }

    @Override
    public Optional<Port> findById(Integer id) throws DaoException {
        return Optional.empty();
    }

    @Override
    public boolean delete(Integer id) throws DaoException {
        return false;
    }

    @Override
    public boolean create(Port entity) throws DaoException {
        return false;
    }

    @Override
    public boolean update(Port entity) throws DaoException {
        return false;
    }

    public static Port extractPort(ResultSet rs) {
        Port port = new Port();
        try {
            port.setCity(rs.getString(Fields.PORT_CITY));
            port.setCountry(rs.getString(Fields.PORT_COUNTRY));

            return port;
        } catch (SQLException e) {
            throw new IllegalStateException(e);
        }
    }
}