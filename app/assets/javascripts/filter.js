$(document).ready(function() {
    $('.dropdown-toggle').dropdown();

    var $container = $('.portfolio-wrapper');

    $container.imagesLoaded( function(){
      $container.isotope({
        itemSelector : '.card',
        layoutMode : 'fitRows'
      });
    });

    // Needed functions
    var getColWidth = function() {
      var width,
      windowWidth = $(window).width();
      if( windowWidth <= 480 ) {
        width = Math.floor( $container.width() );
      } else if( windowWidth <= 768 ) {
        width = Math.floor( $container.width() );
      } else {
        width = Math.floor( 250 );
      }
      return width;
    }

    function setWidths() {
      var colWidth = getColWidth();
      $container.children().css({ width: colWidth });
    }


    $(window).smartresize(function() {
      setWidths();
      $container.isotope({
        masonry: {
          columnWidth: getColWidth()
        }
      });
    });

    $('.filter-portfolio li a').click(function(){
      $('.filter-portfolio li.active').removeClass('active');
      $(this).parent('li').addClass('active');
      var selector = $(this).attr('data-filter');
      $container.isotope({
        filter: selector,
        masonry: {  }
      });
      return false;
    });
    // update columnWidth on window resize
    $(window).smartresize(function(){
      $container.isotope({
        // update columnWidth to a percentage of container width
        masonry: {  }
      });
    });

  });
