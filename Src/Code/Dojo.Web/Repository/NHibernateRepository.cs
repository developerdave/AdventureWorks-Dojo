namespace Dojo.Web.Repository
{
    using System.Collections.Generic;
    using NHibernate;
    using NHibernate.Criterion;

    public class NHibernateRepository<T> : IRepository<T>
    {
        private readonly ISession _session;

        public NHibernateRepository()
        {
            _session = NHibernateSessionManager.Instance.GetSession();
            _session.BeginTransaction();
        }

        public void Save(T obj)
        {
            _session.Save(obj);
        }

        public void Update(T obj)
        {
            _session.Update(obj);
        }

        public void Delete(T obj)
        {
            _session.Delete(obj);
        }

        public T Load<T1>(object id)
        {
            return _session.Load<T>(id);
        }

        public T GetReference<T>(object id)
        {
            return _session.Get<T>(id);
        }

        public void DeleteAll(IList<T> items)
        {
            for (var i = 0; i < items.Count; ++i)
            {
                Delete(items[i]);
            }
        }

        public void UpdateAll(IList<T> items)
        {
            for (var i = 0; i < items.Count; ++i)
            {
                Update(items[i]);
            }
        }

        public void InsertAll(IList<T> items)
        {
            for (var i = 0; i < items.Count; ++i)
            {
                Save(items[i]);
            }
        }

        public IList<T> GetAll<T>()
        {
            return GetAll<T>(0, 0);
        }

        public IList<T> GetAllOrdered<T>(string propertyName, bool ascending)
        {
            var cr1 = new Order(propertyName, ascending);
            var results = _session.CreateCriteria(typeof(T)).AddOrder(cr1).List<T>();
            return results;
        }

        public IList<T> Find<T>(IList<string> criteria)
        {
            IList<ICriterion> objs = new List<ICriterion>();
            foreach (var s in criteria)
            {
                ICriterion cr1 = Expression.Sql(s);
                objs.Add(cr1);
            }

            var myCriteria = _session.CreateCriteria(typeof(T));
            foreach (var rest in objs)
                _session.CreateCriteria(typeof(T)).Add(rest);

            myCriteria.SetFirstResult(0);
            return myCriteria.List<T>();
        }

        public void Detach(T item)
        {
            _session.Evict(item);
        }

        public IList<T> GetAll<T>(int pageIndex, int pageSize)
        {
            var criteria = _session.CreateCriteria(typeof(T));
            criteria.SetFirstResult(pageIndex * pageSize);
            if (pageSize > 0)
            {
                criteria.SetMaxResults(pageSize);
            }

            return criteria.List<T>();
        }

        public void Commit()
        {
            if (_session.Transaction.IsActive)
            {
                _session.Transaction.Commit();
            }
        }

        public void Rollback()
        {
            if (!_session.Transaction.IsActive) return;

            _session.Transaction.Rollback();
            _session.Clear();
        }

        public void BeginTransaction()
        {
            Rollback();
            _session.BeginTransaction();
        }
    }
}