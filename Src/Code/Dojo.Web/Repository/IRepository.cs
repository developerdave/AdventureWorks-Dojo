namespace Dojo.Web.Repository
{
    using System.Collections.Generic;

    public interface IRepository<T>
    {
        void Save(T obj);
        void Update(T obj);
        void Delete(T obj);
        T Load<T1>(object id);
        T GetReference<T>(object id);
        void DeleteAll(IList<T> items);
        void UpdateAll(IList<T> items);
        void InsertAll(IList<T> items);
        IList<T> GetAll<T>();
        IList<T> GetAllOrdered<T>(string propertyName, bool ascending);
        IList<T> Find<T>(IList<string> criteria);
        void Detach(T item);
        IList<T> GetAll<T>(int pageIndex, int pageSize);
        void Commit();
        void Rollback();
        void BeginTransaction();
    }
}