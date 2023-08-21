using System.ComponentModel.DataAnnotations;

namespace ShareResource.DTO
{
    public class AccountChangePasswordDto : BaseUpdateDto
    {
        [Key]
        public int Id { get; set; }
      
        public string OldPassword { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }

    }
}
