namespace Dojo.Tests.Unit
{
    using NUnit.Framework;
    using Web.Controllers;

    [TestFixture]
    public class HomeControllerTest
    {
        private HomeController _controller;

        [SetUp]
        public void SetUp()
        {
            _controller = new HomeController();  
        }

        [Test]
        public void index_should_return_view_when_called()
        {
            var result = _controller.Index();
            MvcContrib.TestHelper.ActionResultHelper.AssertViewRendered(result);
        } 

        [Test]
        public void index_should_set_view_data_when_called()
        {
            _controller.Index();
            Assert.That(_controller.ViewData["Message"], Is.Not.Null.Or.Empty); 
        }

        [Test]
        public void about_should_return_view_when_called()
        {
            var result = _controller.About();
            MvcContrib.TestHelper.ActionResultHelper.AssertViewRendered(result);
        }
    }
}