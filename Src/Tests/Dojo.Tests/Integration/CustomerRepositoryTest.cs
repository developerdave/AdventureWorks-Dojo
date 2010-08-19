namespace Dojo.Tests.Integration
{
    using NUnit.Framework;
    using Web.Models;
    using Web.Repository;

    [TestFixture]
    public class CustomerRepositoryTest
    {
        [Test]
        public void getall_should_get_a_list_of_customers()
        {
            var repository = new NHibernateRepository<Customer>();
            var customers = repository.GetAll<Customer>();
            Assert.That(customers, Is.Not.Empty);
        }
    }
}