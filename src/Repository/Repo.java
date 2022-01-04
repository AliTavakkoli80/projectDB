package Repository;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.Collection;
import java.util.List;

public interface Repo<Entity,ID extends Serializable> {
    Entity findById(ID id) throws SQLException;
    List<Entity> findByIDs(Collection<ID> ids) throws SQLException;
    List<Entity> findAll() throws SQLException;
    Boolean deleteByID(ID id) throws SQLException;
    Boolean deleteByIDs(Collection<ID> ids) throws SQLException;
    Boolean add(Entity E) throws SQLException;
    Boolean addAll(Collection<Entity> entities) throws SQLException;
    Boolean update(Entity E) throws SQLException;
}
