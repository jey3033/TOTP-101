<section>
    <form id="form-login">
        <label for="user-email">Email</label>
        <input type="email" name="email" id="user-email" placeholder="masukan email">
        <label for="user-password">Password</label>
        <input type="password" name="pass" id="user-password">
        <button type="button" id="createOTP">Create OTP</button>
    </form>
</section>

<div class="modal" id="modal-totp" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Here's Your TOTP</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="totp-body">
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('#createOTP').click(function() {
            $.ajax({
                url: "{$BaseHref}login/createOTP",
                type: "POST",
                data: $('#form-login').serialize(),
                async: true,
                success: function(result) {
                    let decResult = $.parseJSON(result);
                }
            })
        })
    })    
</script>